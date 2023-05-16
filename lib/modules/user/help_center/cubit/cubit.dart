import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/help_center/cubit/states.dart';

class HelpCenterCubit extends Cubit<HelpCenterStates> {
  HelpCenterCubit() : super(HelpCenterInitialState());

  static HelpCenterCubit get(context) => BlocProvider.of(context);

  int currentIndexForFirstTabBar = 0;
  void changeFirstTabBarIndex(int index) {
    currentIndexForFirstTabBar = index;
    emit(HelpCenterChangeTabBarIndexState());
  }

  int currentIndexForSecondTabBar = 0;
  void changeSecondTabBarIndex(int index) {
    currentIndexForSecondTabBar = index;
    emit(HelpCenterChangeSecondTabBarIndexState());
  }

/*
  UserModel? userModel;

  void getUserDataFromFB({
    required BuildContext context,
  }) {
    emit(GetUserFromFBLoadingState());
    FirebaseFirestore.instance
        .collection(
            context.read<UserProfileCubit>().userInfo!.companyName == null
                ? 'Users'
                : "Companies")
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserFromFBSuccessState());
    }).catchError((error) {
      emit(GetUserFromFBErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required BuildContext context,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: uId,
      receiverId: receiverId,
      dateTime: DateTime.now().toIso8601String(),
      text: text,
    );

    // Set my chats
    FirebaseFirestore.instance
        .collection(
            context.read<UserProfileCubit>().userInfo!.companyName == null
                ? 'Users'
                : "Companies")
        .doc(uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // Set receiver chats
    FirebaseFirestore.instance
        .collection("Companies")
        .doc(receiverId)
        .collection("Chats")
        .doc(uId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      // If the "Chats" subcollection doesn't exist, create it and then add the message
      if (error is FirebaseException && error.code == 'not-found') {
        FirebaseFirestore.instance
            .collection(
                context.read<UserProfileCubit>().userInfo!.companyName == null
                    ? 'Users'
                    : "Companies")
            .doc(receiverId)
            .collection("Chats")
            .doc(uId)
            .set({}).then((_) {
          // Retry adding the message after creating the "Chats" subcollection
          FirebaseFirestore.instance
              .collection(
                  context.read<UserProfileCubit>().userInfo!.companyName == null
                      ? 'Users'
                      : "Companies")
              .doc(receiverId)
              .collection("Chats")
              .doc(uId)
              .collection("Messages")
              .add(messageModel.toMap())
              .then((value) {
            emit(SendMessageSuccessState());
          }).catchError((error) {
            emit(SendMessageErrorState());
          });
        });
      } else {
        emit(SendMessageErrorState());
      }
    });
  }

  StreamSubscription<dynamic> messagesSubscription =
      const Stream.empty().listen((_) {});

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
    required BuildContext context,
  }) {
    messagesSubscription.cancel();
    messagesSubscription = FirebaseFirestore.instance
        .collection(
            context.read<UserProfileCubit>().userInfo!.companyName == null
                ? 'Users'
                : "Companies")
        .doc(uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime",
            descending: false) // Order messages by timestamp in ascending order
        .snapshots()
        .listen((event) {
      List<MessageModel> newMessages =
          []; // Create a new list to hold the updated messages
      for (var element in event.docs) {
        newMessages.add(MessageModel.fromJson(element.data()));
      }
      messages = newMessages;
      emit(ReceiveMessageSuccessState(
          messages: newMessages)); // Emit the state with the updated messages
    });
  }*/
}
