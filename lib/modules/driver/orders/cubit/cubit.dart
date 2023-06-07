import 'package:dio/dio.dart';
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

  DelegateGetHisOrders? delegateGetHisOrders;
  void getOrdersRelatedToDelegate() {
    emit(GetOrdersRelatedToDelegateLoadingState());
    DioHelper.getData(
      url: DELEGATEGETHISORDERS,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      delegateGetHisOrders = DelegateGetHisOrders.fromJson(value.data);
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
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(DelegateTakeOrderErrorState(errorMessage));
      }
    });
  }

  DelegateOrderDetails? delegateOrderDetails;
  void delegateGetOrderById({
    required String orderId,
}) {
    emit(GetDriverOrderLoadingState());
    DioHelper.getData(
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
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(GetDriverOrdersErrorState(errorMessage));
      }
    });
  }

  void driverDoneOrder({
    required String orderId,
    required String confirmType,
  }) {
    emit(DriverConfirmOrderLoadingState());
    DioHelper.patchData(
      url: "$DELEGATECONFIRMORDER$orderId",
      baseUrl: BASEURL,
      token: driverToken,
      query: {
        "type": confirmType,
      }
    ).then((value) {
      final message = value.data.toString();
      emit(DriverConfirmOrderSuccessState(message));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DriverConfirmOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DriverConfirmOrderErrorState(errorMessage));
        }
      } else {
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(DriverConfirmOrderErrorState(errorMessage));
      }
    });
  }
}