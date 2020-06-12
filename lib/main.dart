import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:thirtyDayPassion/HomePage.dart';
import 'QuestionsPage.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle
        .loadString('assets/fonts/Barlow_Semi_Condensed/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return CupertinoApp(
      title: 'Thirty Day Passion',
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
              fontFamily: 'Barlow',
              letterSpacing: 0.4,
          ),
        ),
      ),

      home: QuestionsPage(),
    );
  }
}
