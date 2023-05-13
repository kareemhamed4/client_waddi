import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void getOrdersByTrackId({
    required String trackId,
  }) {
    emit(GetUserSearchedOrdersLoadingState());
    DioHelper.getData(
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
}
