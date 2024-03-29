import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/order_details.dart';
import 'package:waddy_app/modules/user/make_order/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class MakeOrderCubit extends Cubit<MakeOrderStates> {
  MakeOrderCubit() : super(MakeOrderInitialState());

  static MakeOrderCubit get(context) => BlocProvider.of(context);

  OrderDetails? orderDetails;
  void makeOrder({
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
  }) {
    emit(MakeOrderLoadingState());
    DioHelper.postData(
      url: MAKEORDER,
      baseUrl: BASEURL,
      token: userToken,
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
        "notes": notes,
      },
    ).then((value) {
      orderDetails = OrderDetails.fromJson(value.data);
      emit(MakeOrderSuccessState(orderDetails!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(MakeOrderErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(MakeOrderErrorState(errorMessage));
        }
      } else {
        final responseData = error.response?.data;
        final errorMessage = responseData['msg'];
        emit(MakeOrderErrorState(errorMessage));
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
      orderDetails = OrderDetails.fromJson(value.data);
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
}
