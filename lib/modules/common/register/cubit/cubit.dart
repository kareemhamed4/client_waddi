import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/register/cubit/states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

}
