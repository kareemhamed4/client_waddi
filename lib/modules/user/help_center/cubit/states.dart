import 'package:waddy_app/models/common/message_model.dart';

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
class ReceiveMessageSuccessState extends HelpCenterStates {
  final List<MessageModel> messages;

  ReceiveMessageSuccessState({required this.messages});
}