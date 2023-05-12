import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';

class GetDriverOrdersCubit extends Cubit<GetDriverOrdersStates> {
  GetDriverOrdersCubit() : super(GetUserOrdersInitialState());

  static GetDriverOrdersCubit get(context) => BlocProvider.of(context);

}