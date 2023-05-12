import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/attach_bill/cubit/states.dart';

class SendBillCubit extends Cubit<SendBillStates> {
  SendBillCubit() : super(SendBillInitialState());

  static SendBillCubit get(context) => BlocProvider.of(context);

}