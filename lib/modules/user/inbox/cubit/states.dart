abstract class UserInboxStates {}
class UserChatInitialState extends UserInboxStates {}
class ChangeInboxIndexState extends UserInboxStates {}

class GetAllUsersLoadingState extends UserInboxStates {}
class GetAllUsersSuccessState extends UserInboxStates {}
class GetAllUsersErrorState extends UserInboxStates {
  final String error;
  GetAllUsersErrorState(this.error);
}

class ReceiveMessageSuccessState extends UserInboxStates {}

class SendMessageSuccessState extends UserInboxStates {}
class SendMessageErrorState extends UserInboxStates {}