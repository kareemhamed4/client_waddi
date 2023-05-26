import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class GetDriverOrdersCubit extends Cubit<GetDriverOrdersStates> {
  GetDriverOrdersCubit() : super(GetDriverOrdersInitialState());

  static GetDriverOrdersCubit get(context) => BlocProvider.of(context);

  List<UserOrders> ordersList = [];
  void getDriverAllOrders() {
    emit(GetDriverOrdersLoadingState());
    DioHelper.getData(
      url: DELEGATEGETALLORDERS,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      List<dynamic> ordersJson = value.data;
      ordersList = ordersJson
          .map((orderJson) => UserOrders.fromJson(orderJson))
          .toList();
      emit(GetDriverOrdersSuccessState(ordersList));
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
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(GetDriverOrdersErrorState(errorMessage));
      }
    });
  }

  UserOrders? userOrder;
  void getDriverOrder({
    required String orderId,
}) {
    emit(GetDriverOrderLoadingState());
    DioHelper.getData(
      url: "$DELEGATEGETORDERBYID$orderId",
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      userOrder = UserOrders.fromJson(value.data);
      emit(GetDriverOrderSuccessState(userOrder!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
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