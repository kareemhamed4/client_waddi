import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/register/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

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

/*  void userRegisterWithFB({
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
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      uId = value.user!.uid;
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
  }*/
}
