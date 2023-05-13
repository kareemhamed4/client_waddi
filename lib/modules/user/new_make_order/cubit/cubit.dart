import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/make_order/cubit/states.dart';

class MakeOrderCubit extends Cubit<MakeOrderStates> {
  MakeOrderCubit() : super(MakeOrderInitialState());

  static MakeOrderCubit get(context) => BlocProvider.of(context);

}
