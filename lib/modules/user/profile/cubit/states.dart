abstract class UserProfileStates {}

class UserProfileInitialState extends UserProfileStates {}

class ProfileImagePickedSuccessState extends UserProfileStates {}

class ProfileImagePickedErrorState extends UserProfileStates {}

class ProfileUploadImageLoadingState extends UserProfileStates {}
class ProfileImageUploadSuccessState extends UserProfileStates {
  final String imageUrl;

  ProfileImageUploadSuccessState(this.imageUrl);
}
class ProfileImageUploadErrorState extends UserProfileStates {}

class ProfileUpdateErrorState extends UserProfileStates {}