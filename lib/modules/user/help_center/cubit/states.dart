abstract class HelpCenterStates{}
class HelpCenterInitialState extends HelpCenterStates{}

class HelpCenterChangeTabBarIndexState extends HelpCenterStates{}
class HelpCenterChangeSecondTabBarIndexState extends HelpCenterStates{}
class GetUserFromFBLoadingState extends HelpCenterStates{}
class GetUserFromFBSuccessState extends HelpCenterStates{}
class GetUserFromFBErrorState extends HelpCenterStates{
  final String error;
  GetUserFromFBErrorState(this.error);
}

class SendMessageSuccessState extends HelpCenterStates{}
class SendMessageErrorState extends HelpCenterStates{}
class ReceiveMessageSuccessState extends HelpCenterStates {}

class GetAllUsersFromFBLoadingState extends HelpCenterStates{}
class GetAllUsersFromFBSuccessState extends HelpCenterStates{}
class GetAllUsersFromFBErrorState extends HelpCenterStates{
  final String error;
  GetAllUsersFromFBErrorState(this.error);
}

class GetAllCompaniesFromFBLoadingState extends HelpCenterStates{}
class GetAllCompaniesFromFBSuccessState extends HelpCenterStates{}
class GetAllCompaniesFromFBErrorState extends HelpCenterStates{
  final String error;
  GetAllCompaniesFromFBErrorState(this.error);
}