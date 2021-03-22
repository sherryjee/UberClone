import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uberclone/all_screens/LoginScreen.dart';
import 'package:flutter_uberclone/all_screens/Onboard.dart';
import 'package:flutter_uberclone/all_screens/Onboardfirstpage.dart';
import 'package:flutter_uberclone/all_screens/RegisterScreen.dart';
import 'package:flutter_uberclone/all_screens/mainScreen.dart';
import 'package:flutter_uberclone/datahandler/appDada.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef=FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue,


        visualDensity: VisualDensity.adaptivePlatformDensity),
         initialRoute: Onboard.idScreen,
        routes: {
          Registeration_screen.idScreen:(context)=> Registeration_screen(),
          Login_screen.idScreen:(context)=> Login_screen(),
          MainScreen.idScreen:(context)=> MainScreen(),
          Onboard.idScreen:(context)=> Onboard(),
          Onboardfirstpage.idScreen:(context)=>Onboardfirstpage(),

        },

        //Login_screen(),
      ),
    );
  }
}
