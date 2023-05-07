abstract class DriverInboxStates {}
class DriverChatInitialState extends DriverInboxStates {}
class ChangeInboxIndexState extends DriverInboxStates {}

class GetAllUsersLoadingState extends DriverInboxStates {}
class GetAllUsersSuccessState extends DriverInboxStates {}
class GetAllUsersErrorState extends DriverInboxStates {
  final String error;
  GetAllUsersErrorState(this.error);
}

class ReceiveMessageSuccessState extends DriverInboxStates {}

class SendMessageSuccessState extends DriverInboxStates {}
class SendMessageErrorState extends DriverInboxStates {}