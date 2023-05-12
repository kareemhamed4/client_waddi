import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/create_route/cubit/states.dart';

class RouteCubit extends Cubit<RouteStates> {
  RouteCubit() : super(RouteInitialState());

  static RouteCubit get(context) => BlocProvider.of(context);

}