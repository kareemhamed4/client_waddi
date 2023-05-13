import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waddy_app/cubit/user/states.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/location_helper.dart';

class DriverCubit extends Cubit<UserStates>
{
  DriverCubit() : super(AppInitialStates());

  static DriverCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  Future<void> getMyCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await LocationHelper.getCurrentLocation();
    CacheHelper.saveData(
      key: "currentLocation",
      value: Geolocator.getLastKnownPosition().whenComplete(
            () async {
          currentLocation =
          await Geolocator.getLastKnownPosition().whenComplete(
                () {
              emit(GetCurrentLocationSuccessState());
            },
          );
        },
      ).toString(),
    );
  }
}