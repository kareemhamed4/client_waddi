import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/cubit/common/states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainAppInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);
}
