import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cocktail/constants.dart';
import 'package:my_cocktail/ui_windows/search_window.dart';

void main() {
  //portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyCocktail()));
}

class MyCocktail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //theme -> dark mode
    return MaterialApp(
      home: SearchWindow(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
    );
  }
}
