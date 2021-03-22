


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uberclone/Allwedget/ProgressDialog/ProgressDialog.dart';
import 'package:flutter_uberclone/all_screens/LoginScreen.dart';
import 'package:flutter_uberclone/all_screens/mainScreen.dart';
import 'package:flutter_uberclone/main.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Registeration_screen extends StatelessWidget {
  static const String idScreen="Register";
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController PasswordTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController PhoneTextEditingController=TextEditingController();



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
                  keyboardType: TextInputType.name,
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                        fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                        fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),

                ),


                TextField(

                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: PasswordTextEditingController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),

                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: PhoneTextEditingController,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    labelStyle: TextStyle(
                        fontSize: 14.0
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),

                  ),

                ),



                SizedBox(height: 10.0,),
                RaisedButton(
                  onPressed: (){
                    if(nameTextEditingController.text.length<3){
                      Displaymsg("Name mus be 3 Characters", context);


                    }
                    else if(!emailTextEditingController.text.contains("@")){
                      Displaymsg("Email is not valid", context);
                    }
                    else if(PasswordTextEditingController.text.isEmpty){
                      Displaymsg("not valid a valid password", context);
                    }
                    else if(PhoneTextEditingController.text.length<6){
                      Displaymsg("not valid phone numver", context);
                    }
                    else{
                      RegisterUser(context);
                    }

                  }
                  ,

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)
                  ),
                  color: Colors.yellow,

                  child: Container(height: 50.0,
                    child: Center(child: Text("Register",style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),),),),
                )

              ],),),
              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, Login_screen.idScreen, (route) => false);
                },
                child: Text("You have already an Account???"),
              )



            ],
          ),
        ),
      ),
    );
  }
final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  RegisterUser(BuildContext context) async {
    //dialogbox
    showDialog(context: context,barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Registering, Please wait",);
        }

    );

    final User firebaseUser=(await _firebaseAuth.createUserWithEmailAndPassword(email: emailTextEditingController.text.trim(),
        password: PasswordTextEditingController.text.trim()).catchError((errMsg){
      Navigator.pop(context);
          Displaymsg("Error :"+errMsg.toString(), context);
    }) ).user;
    if( User !=null){
      //save user info to fire base
      userRef.child(firebaseUser.uid);
      Map userData={
        "name":nameTextEditingController.text.trim(),
        "email":emailTextEditingController.text.trim(),
        "phone":PhoneTextEditingController.text.trim(),
        "Password":PasswordTextEditingController.text.trim(),

      };
      userRef.child(firebaseUser.uid).set(userData);
      Displaymsg("Congratulations your account has been created ", context);
      Navigator.pushNamedAndRemoveUntil(context ,MainScreen.idScreen, (route) => false);

    }
    else{
      //error accure display error
      Navigator.pop(context);
      Displaymsg("New user  account has not been Created", context);



    }




  }

}
Displaymsg(String msg,BuildContext context){
Fluttertoast.showToast(msg: msg);


}
