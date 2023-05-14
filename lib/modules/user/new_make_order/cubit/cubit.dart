import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/order_details.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class NewMakeOrderCubit extends Cubit<NewMakeOrderStates> {
  NewMakeOrderCubit() : super(NewMakeOrderInitialState());

  static NewMakeOrderCubit get(context) => BlocProvider.of(context);

  OrderDetails? orderDetails;
  String? trackIdForNewOrder;
  void makeNewOrder({
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
      trackIdForNewOrder = orderDetails!.trackId;
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

  int currentStep = 0;
  void plusStepper(){
    currentStep+=1;
    emit(PlusStepperStateState());
  }
  void minusStepper(){
    currentStep-=1;
    emit(MinusStepperStateState());
  }

  bool isSaveSenderAddress = false;
  void changeSaveSenderAddress(bool isEnable){
    isSaveSenderAddress = isEnable;
    emit(ChangeRememberMeState());
  }

  bool isSaveReceiverAddress = false;
  void changeSaveReceiverAddress(bool isEnable){
    isSaveReceiverAddress = isEnable;
    emit(ChangeRememberMeState());
  }

  List<String> packageCategory = [
    "Electronics",
    "Medical Supplies",
    "Artwork & Collectibles",
    "Sporting Goods",
    "Musical Instruments",
    "Pets & Animals",
    "Industrial Equipment",
    "Furniture & Appliances",
    "Personal Items",
    "Small Packages",
    "Medium Packages",
    "Large Packages",
  ];
  String? selectedPackageCategory;

  List<String> serviceCategory = [
    "Regular",
    "Express",
  ];
  String? selectedService;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardExpiryDateController =
  TextEditingController();
  TextEditingController cardCVVController = TextEditingController();


  void changeCardNumber({
    required String cardNumber,
  }){
    cardNumberController.text = cardNumber;
    emit(ChangeCardDataState());
  }

  void changeCardName({
    required String cardName,
  }){
    cardNameController.text = cardName;
    emit(ChangeCardDataState());
  }

  void changeCardDate({
    required String cardExpiryDate,
  }){
    cardExpiryDateController.text = cardExpiryDate;
    emit(ChangeCardDataState());
  }

  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController receiverEmailController = TextEditingController();
  final TextEditingController receiverPostalCodeController =
  TextEditingController();
  final TextEditingController receiverAddressController =
  TextEditingController();

  TextEditingController packageWeightController = TextEditingController();
  TextEditingController packageNotesController = TextEditingController();
  TextEditingController packageLengthController = TextEditingController();
  TextEditingController packageWidthController = TextEditingController();
  TextEditingController packageHeightController = TextEditingController();


  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderPhoneController = TextEditingController();
  final TextEditingController senderEmailController = TextEditingController();
  final TextEditingController senderPostalCodeController =
  TextEditingController();
  final TextEditingController senderAddressController = TextEditingController();

  var senderFormKey = GlobalKey<FormState>();
  var receiverFormKey = GlobalKey<FormState>();
  var packageFormKey = GlobalKey<FormState>();
  var paymentFormKey = GlobalKey<FormState>();
}
