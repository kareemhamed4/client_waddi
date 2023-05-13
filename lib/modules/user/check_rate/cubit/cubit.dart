import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/states.dart';

class CheckRateCubit extends Cubit<CheckRateStates>{
  CheckRateCubit(): super(CheckRateInitialState());

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
}