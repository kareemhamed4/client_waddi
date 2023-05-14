import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/new_register/cubit/states.dart';

class NewRegisterCubit extends Cubit<NewRegisterStates>{
  NewRegisterCubit(): super(NewRegisterInitialState());

  NewRegisterCubit get(context) => BlocProvider.of(context);

  int currentIndexForTabBar = 0;
  void changeTabBarIndex(int index){
    currentIndexForTabBar = index;
    emit(NewRegisterChangeTabBarIndexState());
  }

  final TextEditingController personalEmailController = TextEditingController();
  final TextEditingController personalFirstNameController = TextEditingController();
  final TextEditingController personalLastNameController = TextEditingController();
  final TextEditingController personalPasswordController = TextEditingController();
  final TextEditingController personalConfirmPasswordController = TextEditingController();
  final TextEditingController personalPhoneController = TextEditingController();
  final TextEditingController personalAddressController =
  TextEditingController();

  var personalAccountFormKey = GlobalKey<FormState>();
  var companyAccountFormKey = GlobalKey<FormState>();
}