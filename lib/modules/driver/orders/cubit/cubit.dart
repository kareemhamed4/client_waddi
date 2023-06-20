import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/driver/delegate_get_all_orders.dart';
import 'package:waddy_app/models/driver/delegate_get_his_orders_model.dart';
import 'package:waddy_app/models/driver/delegate_get_order_details.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class DriverOrdersCubit extends Cubit<DriverOrdersStates> {
  DriverOrdersCubit() : super(DriverOrdersInitialState());

  static DriverOrdersCubit get(context) => BlocProvider.of(context);
  List<int> tspRouteResult = [];
  late TabController tabController;
  int currentIndexForTabBar = 0;
  void changeFirstTabBarIndex(int index) {
    currentIndexForTabBar = index;
    emit(ChangeTabBarIndexState());
  }

  DelegateOrders? delegateOrders;
  void getDriverAllOrders() {
    emit(GetDriverOrdersLoadingState());
    DioHelper.getData(
      url: DELEGATEGETALLORDERS,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      delegateOrders = DelegateOrders.fromJson(value.data);
      emit(GetDriverOrdersSuccessState(delegateOrders!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverOrdersErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverOrdersErrorState(errorMessage));
        }
      } else {
        emit(GetDriverOrdersErrorState("An error Occurred"));
      }
    });
  }

  int currentCityIndex = 0;
  DelegateGetHisOrders? delegateGetHisOrders;
  Map<String, List<Orders>> ordersByCity = {};
  List<String> emails = [];
  Future<void> getOrdersRelatedToDelegate() async{
    emit(GetOrdersRelatedToDelegateLoadingState());
    await DioHelper.getData(
      url: DELEGATEGETHISORDERS,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      delegateGetHisOrders = DelegateGetHisOrders.fromJson(value.data);
      if(delegateGetHisOrders != null && delegateGetHisOrders!.orders!.isNotEmpty){
        for (int i = 0; i < delegateGetHisOrders!.orders!.length; i++) {
          Orders order = delegateGetHisOrders!.orders![i];
          emails.add(order.receivedEmail!);
          // Store the order's city in a variable
          String city = order.receivedAddress ?? '';

          // Check if the city already exists in the map
          if (ordersByCity.containsKey(city)) {
            // Add the order to the existing city's list
            ordersByCity[city]!.add(order);
          } else {
            // Create a new list for the city and add the order
            ordersByCity[city] = [order];
          }
        }
        getUIdsForUsersFromFB(emails);
      }
      emit(GetOrdersRelatedToDelegateSuccessState(delegateGetHisOrders!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetOrdersRelatedToDelegateErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetOrdersRelatedToDelegateErrorState(errorMessage));
        }
      } else {
        emit(GetOrdersRelatedToDelegateErrorState("An error Occurred"));
      }
    });
  }

  void delegateTakeOrder({
    required String orderId,
  }) {
    emit(DelegateTakeOrderLoadingState());
    DioHelper.postData(
      url: "$DELEGATETAKEORDERBYID$orderId",
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      final index = delegateOrders!.orders!.indexWhere((order) => order.sId == orderId);
      if (index != -1) {
        delegateOrders!.orders!.removeAt(index);
      }
      getDriverAllOrders();
      getOrdersRelatedToDelegate();
      changeFirstTabBarIndex(0);
      tabController.animateTo(0);
      emit(DelegateTakeOrderSuccessState("Order added to your orders Successfully!"));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 409) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DelegateTakeOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DelegateTakeOrderErrorState(errorMessage));
        }
      } else {
        emit(DelegateTakeOrderErrorState(error.toString()));
      }
    });
  }

  DelegateOrderDetails? delegateOrderDetails;
  Future<void> delegateGetOrderById({
    required String orderId,
  }) async{
    emit(GetDriverOrderLoadingState());
    await DioHelper.getData(
      url: "$DELEGATEGETORDERBYID$orderId",
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      delegateOrderDetails = DelegateOrderDetails.fromJson(value.data);
      emit(GetDriverOrderSuccessState(delegateOrderDetails!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverOrderErrorState(errorMessage));
        }
      } else {
        emit(GetDriverOrdersErrorState(error.toString()));
      }
    });
  }

  void driverDoneOrder({
    required String orderId,
    required String confirmType,
  }) {
    if(confirmType == "Rejected"){
      emit(DriverConfirmOrderByRejectLoadingState());
    }else{
      emit(DriverConfirmOrderByAcceptLoadingState());
    }
    DioHelper.patchData(url: "$DELEGATECONFIRMORDER$orderId", baseUrl: BASEURL, token: driverToken, query: {
      "type": confirmType,
    }).then((value) {
      final message = value.data.toString();
      if(confirmType == "Rejected"){
        emit(DriverConfirmOrderByRejectSuccessState(message));
      }else{
        emit(DriverConfirmOrderByAcceptSuccessState(message));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          if(confirmType == "Rejected"){
            emit(DriverConfirmOrderByRejectErrorState(errorMessage));
          }else{
            emit(DriverConfirmOrderByAcceptErrorState(errorMessage));
          }
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          if(confirmType == "Rejected"){
            emit(DriverConfirmOrderByRejectErrorState(errorMessage));
          }else{
            emit(DriverConfirmOrderByAcceptErrorState(errorMessage));
          }
        }
      } else {
        if(confirmType == "Rejected"){
          emit(DriverConfirmOrderByRejectErrorState(error.toString()));
        }else{
          emit(DriverConfirmOrderByAcceptErrorState(error.toString()));
        }
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

  String? filePath;
  String? fileName;
  FilePickerResult? result;
  Future<void> chooseImageFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', "jpg", "jpeg"],
      );
      if (result != null && result!.files.isNotEmpty) {
        filePath = result!.files.last.path!;
        fileName = filePath!.split('/').last;
        emit(ImagePickedSuccessState());
      }
    } catch (e) {
      emit(ImagePickedErrorState());
    }
  }

  Future<void> delegateUploadImageProof({
    required String orderId,
}) async {
    if (filePath!.isEmpty) {
      emit(ImageUploadErrorState("Please choose Image file"));
      return;
    }
    emit(ImageUploadLoadingState());
    try {
      final formData = FormData.fromMap({
        'proof': await MultipartFile.fromFile(filePath!),
      });
      final response = await DioHelper.postData(
        url: "$DELEGATESENDORDERPROOF$orderId",
        baseUrl: BASEURL,
        data: formData,
        token: driverToken,
        contentType: 'multipart/form-data; boundary=${formData.boundary}',
      );
      if (response.statusCode == 200) {
        final responseData = response.data.toString();
        emit(ImageUploadSuccessState(responseData));
      } else {
        final responseData = response.data.toString();
        emit(ImageUploadErrorState(responseData));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ImageUploadErrorState(
          "Error while uploading your offer, try again!"));
    }
  }

  void deleteSelectedImage() {
    filePath = null;
    fileName = null;
    result = null;
    emit(ImageDeletedSuccessState());
  }
}
