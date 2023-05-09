import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/search/cubit/states.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class UserSearchOrderCubit extends Cubit<UserSearchOrderStates> {
  UserSearchOrderCubit() : super(UserSearchOrderInitialState());

  static UserSearchOrderCubit get(context) => BlocProvider.of(context);

  UserOrders? orderDetails;
  void getOrderId({
    required String orderId
}) {
    emit(UserSearchOrderIdLoadingState());
    DioHelper.getData(
      url: "$USERSEARCHORDERID$orderId",
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      orderDetails = UserOrders.fromJson(value.data);
      emit(UserSearchOrderIdSuccessState(orderDetails!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          const errorMessage = "Not Found";
          emit(UserSearchOrderIdNotFoundState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserSearchOrderIdErrorState(errorMessage));
        }
      } else {
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(UserSearchOrderIdErrorState(errorMessage));
      }
    });
  }

  void getTrackId({
    required String trackId
  }) {
    emit(UserSearchTrackIdLoadingState());
    DioHelper.getData(
      url: "$USERSEARCHTRACKID$trackId",
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      orderDetails = UserOrders.fromJson(value.data);
      emit(UserSearchTrackIdSuccessState(orderDetails!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          const errorMessage = "Not Found";
          emit(UserSearchTrackIdNotFoundState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserSearchTrackIdErrorState(errorMessage));
        }
      } else {
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(UserSearchTrackIdErrorState(errorMessage));
      }
    });
  }
}
