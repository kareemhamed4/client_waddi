import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/cubit/common/states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainAppInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  Map<String, String> emailToUidMap = {};
  Future<void> getUIdsForUsersFromFB(List<String> emails) async {
    await Future.wait(emails.map((email) async {
      return await FirebaseFirestore.instance
          .collectionGroup('Users')
          .where('email', isEqualTo: email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.size > 0) {
          final document = querySnapshot.docs.first;
          final uId = document.id;
          emailToUidMap[email] = uId;
        }
      });
    })).then((_) async {
      if (emailToUidMap.isNotEmpty) {
        final List<String?> uIds = emails.map((email) => emailToUidMap[email]).toList();
        emit(UserUIdsLoaded(uIds));
      } else {
        await Future.wait(emails.map((email) async {
          return await FirebaseFirestore.instance
              .collectionGroup('Delegates')
              .where('email', isEqualTo: email)
              .get()
              .then((querySnapshot) {
            if (querySnapshot.size > 0) {
              final document = querySnapshot.docs.first;
              final uId = document.id;
              emailToUidMap[email] = uId;
            }
          });
        })).then((_) {
          if (emailToUidMap.isNotEmpty) {
            final List<String?> uIds = emails.map((email) => emailToUidMap[email]).toList();
            emit(UserUIdsLoaded(uIds));
          } else {
            emit(UserNotFound());
          }
        }).catchError((error) {
          emit(UserFetchError(error.toString()));
        });
      }
    }).catchError((error) {
      emit(UserFetchError(error.toString()));
    });
  }
}
