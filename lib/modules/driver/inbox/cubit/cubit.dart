import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/inbox/cubit/states.dart';

class DriverInboxCubit extends Cubit<DriverInboxStates> {
  DriverInboxCubit() : super(DriverChatInitialState());

  static DriverInboxCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isChats = true;
  changeInboxIndex(int index){
    currentIndex = index;
    isChats = currentIndex == 0 ? true : false;
    emit(ChangeInboxIndexState());
  }
}