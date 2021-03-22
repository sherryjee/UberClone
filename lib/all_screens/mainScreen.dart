import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uberclone/Assisttants/assiststantmethod.dart';
import 'package:flutter_uberclone/all_screens/searchScreen.dart';
import 'package:flutter_uberclone/datahandler/appDada.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  @override

  static const String idScreen="Main";
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //camera position
  Completer<GoogleMapController> _controllerGooglemap = Completer();
GlobalKey<ScaffoldState> Scaffordkey=new  GlobalKey<ScaffoldState>();
GoogleMapController newGoogleMapController;
//position
Position currentPosition;
var geoLocator =Geolocator();


void LocatePotion() async{
  Position position = await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  currentPosition =position;
  LatLng latlatposition=LatLng(position.altitude, position.latitude);

  CameraPosition Cameraposition= CameraPosition(target: latlatposition,zoom: 14);
  newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(Cameraposition));
  //request assintant object
  String address=await  AssistantMethods.SearchCoordinateAddress(position,context);
  print("this is your Address  : :" + address);



}
double bottompadding=0.0;



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Scaffordkey,
      appBar: AppBar(title: Text("UBER CLONE"),),
      drawer: Container(
        width: 255.0,
        color: Color(0xff8c8c8c),
        child: Drawer(
          child: ListView(
            children: [
              Container(child: DrawerHeader(decoration: BoxDecoration(color: Colors.white38,),child: Row(children: [
                Image.asset("images/user_icon.png",height: 65.0,width: 65.0,),
                SizedBox(width: 16.0,),
                Column(mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Profile Name",style: TextStyle(fontSize: 16.0,fontFamily: "Brand Bold"),),
                  SizedBox(height: 6.0,),
                  Text("Visit Profile"),

                ],)
              ],),),height: 165.0,),
              Divider(),
              SizedBox(height: 12.0,),
              //drawerbody
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History",style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit Profile",style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.settings_applications),
                title: Text("Setting",style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.app_blocking_outlined),
                title: Text("About",style: TextStyle(fontSize: 15.0),),
              )


            ],
          ),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: bottompadding),

          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,

          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController  controller){
            _controllerGooglemap.complete(controller);
            newGoogleMapController=controller;

            setState(() {
              bottompadding=300.0;
            });
            //locate postion method
            LocatePotion();
          },
        ),
        //hamburgerbutton
        GestureDetector(
          onTap: (){
            Scaffordkey.currentState.openDrawer();

          },
          child: Container(margin:EdgeInsets.only(left: 10.0,top: 45.0),
            decoration: BoxDecoration(
              color: Color(0xff8c8c8c),
              borderRadius: BorderRadius.circular(22.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  offset: Offset(0.7,0.7),),
              ]
            ),
            child: CircleAvatar(backgroundColor: Colors.white38,

             child: Icon(Icons.menu,color: Colors.black),
            radius: 20.0,
            ),
          ),
        ),

        Positioned(
          left: 0.0,
            right: 0.0,
            bottom: 0.0,

            child: Container(
//              color: Colors.white,
              height: 300.0,
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7)),


                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 6.0,),
                    Text("hi there",style:  TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                    Text("where to?",style: TextStyle(fontSize: 25.0,fontFamily:"Brand Bold"),),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>searchScreen()));
                      },
                      child: Container(

                        decoration:BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(color: Colors.black54,

                                  blurRadius: 16.0,

                                  spreadRadius: 0.5,
                                  offset: Offset(0.7,0.7)),

                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.yellowAccent,),
                              SizedBox(width: 10.0,),
                              Text("Search Drop off location")
                            ],
                          ),
                        ),

                        ),
                    ),
                    SizedBox(height: 24.0,),
                    Row(
                      children: [
                        Icon(Icons.home,color: Colors.grey),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            Provider.of<AppData>(context).pickupLocation !=null? Provider.of<AppData>(context).pickupLocation.placeName:"Add Home"
                            ),
                            SizedBox(height: 4.0,),
                            Text("Your Living Home Address",style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Divider(
                      height: 2.0,
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                    SizedBox(height: 16.0,),

                    Row(
                      children: [
                        Icon(Icons.work,color:Colors.grey),
                        SizedBox(width: 12.0,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Add home"),
                           SizedBox(height: 4.0,),
                           Text("Your office address",style: TextStyle(color: Colors.grey[200],fontSize: 12.0),),

                         ],
                       )
                      ],
                    )


                  ],
                ),
              ),
            ))
      ],),
    );
  }
}
