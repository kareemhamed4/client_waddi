import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/states.dart';

class NewMakeOrderCubit extends Cubit<NewMakeOrderStates> {
  NewMakeOrderCubit() : super(NewMakeOrderInitialState());

  static NewMakeOrderCubit get(context) => BlocProvider.of(context);

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
}
