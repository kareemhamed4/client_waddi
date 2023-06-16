import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersStates> {
  GetUserOrdersCubit() : super(GetUserOrdersInitialState());

  static GetUserOrdersCubit get(context) => BlocProvider.of(context);

  UserOrders? userOrders;
  UserOrders? searchedOrderDetails;
  List<UserOrders> ordersList = [];
  List<String> emails = [];
  void getOrders() {
    emit(GetUserOrdersLoadingState());
    DioHelper.getData(
      url: GETUSERORDERS,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      List<dynamic> ordersJson = value.data;
      ordersList = ordersJson
          .map((orderJson) => UserOrders.fromJson(orderJson))
          .toList();
      for (int i = 0; i < ordersList.length; i++) {
        userOrders = ordersList[i];
        userOrders!.originalIndex = i;
      }
      if(userOrders != null && ordersList.isNotEmpty){
        for (int i = 0; i < ordersList.length; i++) {
          UserOrders order = ordersList[i];
          if (order.delegate != null && order.delegate!.email != null) {
            emails.add(order.delegate!.email!);
          }
        }
        getUIdsForUsersFromFB(emails);
      }
      emit(GetUserOrdersSuccessState(ordersList));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetUserOrdersErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetUserOrdersErrorState(errorMessage));
        }
      } else {
        print(error.toString());
        emit(GetUserOrdersErrorState(error.toString()));
      }
    });
  }

  Future<void> getOrdersByTrackId({
    required String trackId,
  }) async {
    emit(GetUserSearchedOrdersLoadingState());
    await DioHelper.getData(
      url: "$USERSEARCHTRACKID$trackId",
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      searchedOrderDetails = UserOrders.fromJson(value.data['order']);
      emit(GetUserSearchedOrdersSuccessState(searchedOrderDetails!));
    }).catchError((error) {
      // Handle error cases and emit GetUserSearchedOrdersErrorState
    });
  }

  void clearSearchedOrderDetails() {
    searchedOrderDetails = null;
  }

  Future<void> deleteOrder({
    required String orderId,
  }) async{
    emit(DeleteOrderLoadingState());
    DioHelper.deleteData(
      url: "$DELETEORDER$orderId",
      token: userToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(DeleteOrderSuccessState());
      getOrders();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DeleteOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(DeleteOrderErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(DeleteOrderErrorState('An error occurred. Please try again.'));
      }
    });
  }

  Map<String, String> emailToUidMap = {};
  Future<void> getUIdsForUsersFromFB(List<String> emails) async {
    await Future.wait(emails.map((email) async {
      return await FirebaseFirestore.instance
          .collectionGroup('Users')
          .where('email', isEqualTo: email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.size > 0) {
          final document = querySnapshot.docs.first;
          final uId = document.id;
          emailToUidMap[email] = uId;
        }
      });
    })).then((_) async {
      if (emailToUidMap.isNotEmpty) {
        final List<String?> uIds = emails.map((email) => emailToUidMap[email]).toList();
        emit(UserUIdsLoaded(uIds));
      } else {
        await Future.wait(emails.map((email) async {
          return await FirebaseFirestore.instance
              .collectionGroup('Delegates')
              .where('email', isEqualTo: email)
              .get()
              .then((querySnapshot) {
            if (querySnapshot.size > 0) {
              final document = querySnapshot.docs.first;
              final uId = document.id;
              emailToUidMap[email] = uId;
            }
          });
        })).then((_) {
          if (emailToUidMap.isNotEmpty) {
            final List<String?> uIds = emails.map((email) => emailToUidMap[email]).toList();
            emit(UserUIdsLoaded(uIds));
          } else {
            emit(UserNotFound());
          }
        }).catchError((error) {
          emit(UserFetchError(error.toString()));
        });
      }
    }).catchError((error) {
      emit(UserFetchError(error.toString()));
    });
  }
}

void launchPhoneApp(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunch(phoneUri.toString())) {
    await launch(phoneUri.toString());
  } else {
    throw 'Could not launch phone app';
  }
}