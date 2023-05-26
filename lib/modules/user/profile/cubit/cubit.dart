import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/user/profile/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

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

  void updateUserDataInFB({
    required BuildContext context,
    String? image,
  }) {
    UserModelFB model = UserModelFB(
      companyName: UserLayoutCubit.get(context).userModelFB!.companyName,
      email: UserLayoutCubit.get(context).userModelFB!.email,
      image: image,
      name: UserLayoutCubit.get(context).userModelFB!.name,
      phone: UserLayoutCubit.get(context).userModelFB!.phone,
      uId: UserLayoutCubit.get(context).userModelFB!.uId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      UserLayoutCubit.get(context).getUserDataFromFB();
    }).catchError((error) {
      print(error.toString());
      emit(ProfileUpdateErrorState());
    });
  }

  void uploadUserImageToFB({
    required BuildContext context,
  }) {
    emit(ProfileUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("Users Images/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        String imageUrl = value;
        emit(ProfileImageUploadSuccessState(imageUrl));
        updateUserDataInFB(
          context: context,
          image: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(ProfileImageUploadErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ProfileImageUploadErrorState());
    });
  }
}
