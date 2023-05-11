import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/inbox/cubit/states.dart';

class UserInboxCubit extends Cubit<DriverInboxStates> {
  UserInboxCubit() : super(DriverChatInitialState());

  static UserInboxCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isChats = true;
  changeInboxIndex(int index){
    currentIndex = index;
    isChats = currentIndex == 0 ? true : false;
    emit(ChangeInboxIndexState());
  }
}