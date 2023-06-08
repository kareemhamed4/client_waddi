import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waddy_app/modules/driver/profile/cubit/states.dart';

class DriverProfileCubit extends Cubit<DriverProfileStates> {
  DriverProfileCubit() : super(DriverProfileInitialState());

  static DriverProfileCubit get(context) => BlocProvider.of(context);
  var picker = ImagePicker();

  File? profileImage;
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }
}
