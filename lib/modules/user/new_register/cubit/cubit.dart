import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/user/new_register/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/components/components.dart';

class NewRegisterCubit extends Cubit<NewRegisterStates> {
  NewRegisterCubit() : super(NewRegisterInitialState());

  NewRegisterCubit get(context) => BlocProvider.of(context);

  int currentIndexForTabBar = 0;
  void changeTabBarIndex(int index) {
    currentIndexForTabBar = index;
    emit(NewRegisterChangeTabBarIndexState());
  }

  Future<void> userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String address,
  }) async{
    emit(UserSignUpLoadingState());
    DioHelper.postData(
      url: USERREGISTER,
      baseUrl: BASEURL,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'address': address,
      },
    ).then((value) {
      if (value.statusCode == 201 &&
          value.data.toString().contains("Created")) {
        emit(UserSignUpSuccessState(value.data.toString()));
      } else {
        emit(UserSignUpErrorState('An error occurred. Please try again.'));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserSignUpErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserSignUpErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(UserSignUpErrorState('An error occurred. Please try again.'));
      }
    });
  }

  Future<void> companyRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String companyName,
    required String industry,
    required String phone,
    required String governorate,
    required String postalcode,
  }) async{
    emit(CompanySignUpLoadingState());
    DioHelper.postData(
      url: COMPANYREGISTER,
      baseUrl: BASEURL,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'companyName': companyName,
        'industry': industry,
        'phone': phone,
        'governorate': governorate,
        'postalcode': postalcode,
      },
    ).then((value) {
      if (value.statusCode == 201 &&
          value.data.toString().contains("Created")) {
        emit(CompanySignUpSuccessState(value.data.toString()));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(CompanySignUpErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(CompanySignUpErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanySignUpErrorState('An error occurred. Please try again.'));
      }
    });
  }

  void userRegisterWithFB({
    required String email,
    required String password,
    required String name,
    required String image,
    required String phone,
    required BuildContext context,
  }) {
    emit(SignUpWithFBLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
        image: image,
      );
    }).catchError((error) {
      buildErrorToast(
        context: context,
        title: "Oops",
        description: error.toString(),
      );
      emit(SignUpWithFBErrorState());
    });
  }

  void createCreate({
    required String email,
    required String name,
    required String image,
    required String phone,
    required String uId,
  }) {
    UserModelFB model = UserModelFB(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateWithFBSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserCreateWithFBErrorState(error.toString()));
    });
  }

  void companyRegisterWithFB({
    required String email,
    required String password,
    required String name,
    required String companyName,
    required String image,
    required String phone,
    required BuildContext context,
  }) {
    emit(SignUpWithFBLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createCreateForCompany(
        uId: value.user!.uid,
        name: name,
        companyName: companyName,
        email: email,
        phone: phone,
        image: image,
      );
    }).catchError((error) {
      buildErrorToast(
        context: context,
        title: "Oops",
        description: error.toString(),
      );
      emit(SignUpWithFBErrorState());
    });
  }

  void createCreateForCompany({
    required String email,
    required String name,
    required String companyName,
    required String uId,
    required String image,
    required String phone,
  }) {
    UserModelFB model = UserModelFB(
      uId: uId,
      name: name,
      companyName: companyName,
      email: email,
      phone: phone,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('Companies')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateWithFBSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserCreateWithFBErrorState(error.toString()));
    });
  }

  List<String> industry = [
    "Technology",
    "Automobile",
    "Retail",
    "Entertainment",
    "Financial Services",
    "Fast Food",
    "Pharmaceuticals",
    "Fashion and Apparel",
    "Healthcare",
    "Telecommunications",
    "E-commerce",
    "Banking and Financial Technology",
    "Other",
  ];
  String? selectedIndustry;

  bool isPassword = true;
  bool isConfirmPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;
  IconData suffixConfirmIcon = Icons.visibility_off_outlined;

  void changePasswordSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordSuffixState());
  }

  void changeConfirmPasswordSuffixIcon() {
    isConfirmPassword = !isConfirmPassword;
    suffixConfirmIcon =
    isConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeConfirmPasswordSuffixState());
  }


  bool isPasswordCompany = true;
  bool isConfirmPasswordCompany = true;
  IconData suffixIconCompany = Icons.visibility_off_outlined;
  IconData suffixConfirmIconCompany = Icons.visibility_off_outlined;

  void changePasswordSuffixIconCompany() {
    isPasswordCompany = !isPasswordCompany;
    suffixIconCompany =
    isPasswordCompany ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordSuffixState());
  }

  void changeConfirmPasswordSuffixIconCompany() {
    isConfirmPasswordCompany = !isConfirmPasswordCompany;
    suffixConfirmIconCompany =
    isConfirmPasswordCompany ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeConfirmPasswordSuffixState());
  }

  final TextEditingController personalEmailController = TextEditingController();
  final TextEditingController personalFirstNameController =
      TextEditingController();
  final TextEditingController personalLastNameController =
      TextEditingController();
  final TextEditingController personalPasswordController =
      TextEditingController();
  final TextEditingController personalConfirmPasswordController =
      TextEditingController();
  final TextEditingController personalPhoneController = TextEditingController();
  final TextEditingController personalAddressController =
      TextEditingController();

  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController companyFirstNameController =
      TextEditingController();
  final TextEditingController companyLastNameController =
      TextEditingController();
  final TextEditingController companyPasswordController =
      TextEditingController();
  final TextEditingController companyConfirmPasswordController =
      TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController companyGovernorateController =
      TextEditingController();
  final TextEditingController companyPostalCodeController =
      TextEditingController();

  var personalAccountFormKey = GlobalKey<FormState>();
  var companyPersonalInformationFormKey = GlobalKey<FormState>();
  var companyInformationFormKey = GlobalKey<FormState>();

  IconData companyPersonalInformationIcon = FontAwesomeIcons.pen;
  IconData companyInformationIcon = FontAwesomeIcons.pen;

  void changeCompanyPersonalInformationIcon(){
    companyPersonalInformationIcon =
    companyPersonalInformationFormKey.currentState!.validate() ? Icons.check_outlined : FontAwesomeIcons.pen;
    emit(ChangeCompanyPersonalInformationIconState());
  }

  void changeCompanyInformationIcon(){
    companyInformationIcon =
    companyInformationFormKey.currentState!.validate() ? Icons.check_outlined : FontAwesomeIcons.pen;
    emit(ChangeCompanyInformationIconState());
  }
}
