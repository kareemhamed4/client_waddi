import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/states.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersStates> {
  GetUserOrdersCubit() : super(GetUserOrdersInitialState());

  static GetUserOrdersCubit get(context) => BlocProvider.of(context);

  UserOrders? orderDetails;
  List<UserOrders> ordersList = [];
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
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(GetUserOrdersErrorState(errorMessage));
      }
    });
  }

  List<UserOrders> searchedOrdersList = [];
  Future<void> getOrdersByTrackId({
    required String trackId,
}) async{
    emit(GetUserOrdersLoadingState());
    DioHelper.getData(
      url: "$USERSEARCHTRACKID$trackId",
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      List<dynamic> ordersJson = value.data;
      searchedOrdersList = ordersJson
          .map((orderJson) => UserOrders.fromJson(orderJson))
          .toList();
      emit(GetUserOrdersSuccessState(searchedOrdersList));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorMessage = error.response?.data.toString();
          emit(GetUserOrdersErrorState(errorMessage!));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetUserOrdersErrorState(errorMessage));
        }
      } else {
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(GetUserOrdersErrorState(errorMessage));
      }
    });
  }

  void updateOrder({
    required String senderName,
    required String senderPhone,
    required String senderEmail,
    required String senderPostalCode,
    required String senderAddress,
    required String receivedName,
    required String receivedPhone,
    required String receivedEmail,
    required String receivedPostalCode,
    required String receivedAddress,
    required String category,
    required int weight,
    required List<String> dimension,
    required int services,
    required String notes,
    required String paymentId,
    required String deliverTime,
    required String orderId,
  }) {
    emit(UpdateOrderLoadingState());
    DioHelper.patchData(
      url: "$UPDATEORDER$orderId",
      token: userToken,
      baseUrl: BASEURL,
      data: {
        'senderName': senderName,
        'senderPhone': senderPhone,
        'senderEmail': senderEmail,
        'senderPostalCode': senderPostalCode,
        'senderAddress': senderAddress,
        'receivedName': receivedName,
        'receivedPhone': receivedPhone,
        'receivedEmail': receivedEmail,
        'receivedPostalCode': receivedPostalCode,
        'receivedAddress': receivedAddress,
        'category': category,
        'weight': weight,
        'dimension': dimension,
        'services': services,
        'paymentId': paymentId,
        'deliverTime': deliverTime,
      },
    ).then((value) {
      orderDetails = UserOrders.fromJson(value.data);
      emit(UpdateOrderSuccessState(orderDetails!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UpdateOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UpdateOrderErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UpdateOrderErrorState('An error occurred. Please try again.'));
      }
    });
  }

  void deleteOrder({
    required String orderId,
  }) {
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
}
