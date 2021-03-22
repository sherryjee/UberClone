import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uberclone/Allwedget/ProgressDialog/ProgressDialog.dart';
import 'package:flutter_uberclone/all_screens/RegisterScreen.dart';
import 'package:flutter_uberclone/all_screens/mainScreen.dart';
import 'package:flutter_uberclone/main.dart';




class Login_screen extends StatelessWidget {
  static const String idScreen="login";
  // ignore: non_constant_identifier_names
  TextEditingController PasswordTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 35.0,),
              Image(image: AssetImage("images/logo.png"),
              width: 360.0,
              height: 260.0,
              alignment: Alignment.center,),
              SizedBox(height: 1.0,),
              Text("Login as Rider",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: "Brand Bold"),),
              Padding(padding: const EdgeInsets.all(20),child: Column(children: [
                SizedBox(height: 1.0,),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),
                ),
                TextField(
                  controller:PasswordTextEditingController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),

                ),
                SizedBox(height: 10.0,),
                RaisedButton(onPressed: ()

                {
                  if(!emailTextEditingController.text.contains("@")){
                    Displaymsg("Email is not valid", context);
                  }
                  else if(PasswordTextEditingController.text.isEmpty){
                    Displaymsg("not valid a valid password", context);
                  }
                  else{
                  LoginAndAuthticateUser(context);}

                },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)
                  ),
                  color: Colors.yellow,

                  child: Container(height: 50.0,
                  child: Center(child: Text("Login",style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),),),),
                )

              ],),),
              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, Registeration_screen.idScreen, (route) => false);
                },
                child: Text("Do have an Account?..Register Here"),
              )



            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  void LoginAndAuthticateUser(BuildContext context)async {
    showDialog(context: context,barrierDismissible: false,
      builder: (BuildContext context){
      return ProgressDialog(message: "Authenticating, Please wait",);
      }

    );

    final User firebaseUser=(await _firebaseAuth.signInWithEmailAndPassword(email: emailTextEditingController.text.trim(),
        password: PasswordTextEditingController.text.trim()).catchError((errMsg){
          Navigator.pop(context);

      Displaymsg("Error :"+errMsg.toString(), context);
    }) ).user;
    if( User !=null){
      //save user info to fire base


      userRef.child(firebaseUser.uid).once().then( (DataSnapshot snap){
        if(snap.value !=null){
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          Displaymsg("You are logged-in successfully ", context);
        }
        else{
          Navigator.pop(context);
            _firebaseAuth.signOut();
            Displaymsg("Can not be Signin", context);
        }
      });


    }
    else{
      //error accure display error
      Navigator.pop(context);
      Displaymsg("Error Occured can not be sign in", context);



    }


  }
}
