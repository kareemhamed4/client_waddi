import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/help_center/cubit/states.dart';

class HelpCenterCubit extends Cubit<HelpCenterStates>{
  HelpCenterCubit(): super(HelpCenterInitialState());

  HelpCenterCubit get(context) => BlocProvider.of(context);

  int currentIndexForFirstTabBar = 0;
  void changeFirstTabBarIndex(int index){
    currentIndexForFirstTabBar = index;
    emit(HelpCenterChangeTabBarIndexState());
  }

  int currentIndexForSecondTabBar = 0;
  void changeSecondTabBarIndex(int index){
    currentIndexForSecondTabBar = index;
    emit(HelpCenterChangeSecondTabBarIndexState());
  }
}