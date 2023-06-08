import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waddy_app/models/user/client_login_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/common/login/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class WaddyLoginCubit extends Cubit<WaddyLoginStates> {
  WaddyLoginCubit() : super(WaddyLoginInitialState());

  static WaddyLoginCubit get(context) => BlocProvider.of(context);

  ClientModel? clientModel;

  Future<void> userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(UserLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      baseUrl: BASEURL,
      data: {'email': email, 'password': password},
    ).then((value) async {
      clientModel = ClientModel.fromJson(value.data);
      if (clientModel!.user!.role == 2000) {
        bool emailExists = await checkEmailExists(email);
        debugPrint(emailExists.toString());
        if (!emailExists) {
          await delegateRegisterWithFB(
            context: context,
            email: email,
            name: "${clientModel!.user!.firstName!} ${clientModel!.user!.lastName!}",
            password: password,
            phone: clientModel!.user!.phone!,
            image: "assets/images/splash-1.png",
          ).then((value) async {
            await userLoginWithFB(email: email, password: password);
            emit(UserLoginSuccessState(clientModel!));
          });
        } else if (emailExists) {
          await userLoginWithFB(email: email, password: password);
          emit(UserLoginSuccessState(clientModel!));
        }
      } else if (clientModel!.user!.role == 1000) {
        await userLoginWithFB(email: email, password: password);
        emit(UserLoginSuccessState(clientModel!));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserLoginErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UserLoginErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserLoginErrorState('An error occurred. Please try again.'));
      }
    });
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: "password", // Provide a dummy password
      );
      // If the email already exists, the createUserWithEmailAndPassword() method will throw an error
      // If the email doesn't exist, the user will be created successfully
      await userCredential.user?.delete(); // Delete the dummy user

      return false; // Email doesn't exist
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        return true; // Email exists
      }
      return false; // Error occurred or email doesn't exist
    }
  }

  Future<void> delegateRegisterWithFB({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String image,
    required String phone,
  }) async {
    emit(DelegateSignUpWithFBLoadingState());
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
      emit(DelegateSignUpWithFBErrorState());
    });
  }

  void createCreate({
    required String uId,
    required String email,
    required String name,
    required String image,
    required String phone,
  }) {
    UserModelFB model = UserModelFB(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      image: image,
    );
    FirebaseFirestore.instance.collection('Delegates').doc(uId).set(model.toMap()).then((value) {
      emit(DelegateCreateWithFBSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(DelegateCreateWithFBErrorState(error.toString()));
    });
  }

  bool isRememberMe = false;
  void changeRememberMe(bool isEnable) {
    isRememberMe = isEnable;
    emit(ChangeRememberMeState());
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void changeLoginSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(WaddyChangePasswordVisibilityState());
  }

  Future<void> userLoginWithFB({
    required String email,
    required String password,
  }) async {
    emit(LoginWithFBLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginWithFBSuccessState(value.user!.uid));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: myFavColor,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginWithFBErrorState(error.toString()));
    });
  }
}
