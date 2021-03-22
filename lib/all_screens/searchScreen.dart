import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uberclone/datahandler/appDada.dart';
import 'package:provider/provider.dart';
class searchScreen extends StatefulWidget {
  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  TextEditingController pickuptexteditingcontroller= TextEditingController();
  TextEditingController DropOfftexteditingcontroller= TextEditingController();

  @override
  Widget build(BuildContext context) {

    String placeAddress=Provider.of<AppData>(context).pickupLocation.placeName ?? "";

    pickuptexteditingcontroller.text=placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
          height: 215.0,
        decoration: BoxDecoration(color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black,
          spreadRadius: 0.5,offset:Offset(0.7,0.7)),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 25.0,top: 20.0,right: 25.0,bottom: 20.0),
          child: Column(
            children: [
              SizedBox(height: 5.0,),
              Stack(children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    }
                    ,
                    child: Icon(Icons.arrow_back)),
                Center(
                  child: Text("set drop off",style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),),
                )
              ],),
              SizedBox(height: 16.0,),
              Row(children: [
                Image.asset("images/pickicon.png",height: 16.0,width: 16.0),
                SizedBox(height: 18.0,),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(padding: EdgeInsets.all(3.0),
                  child: TextField(controller: pickuptexteditingcontroller
    ,

                    decoration: InputDecoration(
                      hintText: "pickup location",
                      fillColor: Colors.grey[400],
                      filled: true,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),

                    ),
                  ),
                  ),


                ))
              ],),
              SizedBox(height: 16.0,),
              Row(children: [
                Image.asset("images/desticon.png",height: 16.0,width: 16.0),
                SizedBox(height: 18.0,),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(padding: EdgeInsets.all(3.0),
                    child: TextField(controller: DropOfftexteditingcontroller,
                      decoration: InputDecoration(
                        hintText: "Where to?",
                        fillColor: Colors.grey[400],
                        filled: true,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),

                      ),
                    ),
                  ),


                ))
              ],)



            ],
          ),


        ),

      )
        ],
      ),
    );
  }
}
