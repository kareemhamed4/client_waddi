import 'package:waddy_app/models/user/get_check_rate_model.dart';

abstract class CheckRateStates{}
class CheckRateInitialState extends CheckRateStates{}

class CheckRateChangeNoOfPackageState extends CheckRateStates{}
class CheckRateChangeShipDateState extends CheckRateStates{}

class CheckRateLoadingStateState extends CheckRateStates{}
class CheckRateSuccessStateState extends CheckRateStates{
  final CheckRateModel checkRateModel;
  CheckRateSuccessStateState(this.checkRateModel);
}
class CheckRateErrorStateState extends CheckRateStates{
  final String error;
  CheckRateErrorStateState(this.error);
}