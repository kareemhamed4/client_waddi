import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waddy_app/cubit/common/states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainAppInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'kareemhamed818@gmail.com',
      queryParameters: {
        'subject': 'Test Subject :: 😀 :: ${DateTime.now()}',
        'body': 'Test Body',
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}
