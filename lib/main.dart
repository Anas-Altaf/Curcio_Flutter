import 'package:curcio/constants.dart';
import 'package:curcio/data/currency_data.dart';
import 'package:curcio/screens/currency_numpad_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kMainBlueColor, // Change this to your desired color
    statusBarIconBrightness: Brightness.light, // For light icons
  ));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CurrencyData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Rubik',
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: kMainBlueColor,
          ),
          scaffoldBackgroundColor: kMainBlueColor,
        ),
        home: SafeArea(
          child: const CurrencyNumPadScreen(),
        ),
      ),
    );
  }
}
