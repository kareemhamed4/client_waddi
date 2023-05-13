import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_check_rate_model.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class CheckRateCubit extends Cubit<CheckRateStates> {
  CheckRateCubit() : super(CheckRateInitialState());

  CheckRateCubit get(context) => BlocProvider.of(context);

  List<String> noOfPackages = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "more than 10",
  ];
  String? selectedNoOfPackages;

  CheckRateModel? checkRateModel;

  Future<void> checkRate({
    required String pickupLocation,
    required String destinationLocation,
    required int weight,
    required int noOfPackages,
}) async{
    emit(CheckRateLoadingStateState());
    DioHelper.postData(
      url: GETRATE,
      baseUrl: BASEURL,
      data: {
        "Dcountry": pickupLocation,
        "Rcountry": destinationLocation,
        "weight": weight,
        "Npackge": noOfPackages,
      },
      token: userToken,
    ).then((value){
      checkRateModel = CheckRateModel.fromJson(value.data);
      emit(CheckRateSuccessStateState(checkRateModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(CheckRateErrorStateState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(CheckRateErrorStateState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CheckRateErrorStateState('An error occurred. Please try again.'));
      }
    });
  }
}
