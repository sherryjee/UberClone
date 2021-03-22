
import 'package:flutter_uberclone/Assisttants/RequestAssitstant.dart';
import 'package:flutter_uberclone/datahandler/appDada.dart';
import 'package:flutter_uberclone/model/address.dart';
import "package:geolocator/geolocator.dart";
import 'package:provider/provider.dart';

class AssistantMethods {


  static Future<String> SearchCoordinateAddress(Position position,context) async{

    String placeAdress="";
    String st1,st2,st3,st4;
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDVBeBIg8hD5YDNZyuIu8qaUg5LJ_TgEqs";

    var responce=await RequestAssitstant.getRequest(url);
    //check the responce
    if(responce !="failed"){

//      placeAdress = responce["results"][0]["formatted_address"];
    st1=responce["results"][0]["address_components"][3]["long_name"];
    st2=responce["results"][0]["address_components"][4]["long_name"];
    st3=responce["results"][0]["address_components"][5]["long_name"];

    st4=responce["results"][0]["address_components"][6]["long_name"];
    placeAdress=st1+" ,"+st2+" ,"+st3+" ,"+st4;


    Address userPickUpAddress =new Address();
      userPickUpAddress.longitude=position.longitude;
      userPickUpAddress.latitude=position.latitude;
      userPickUpAddress.placeName=placeAdress;
      Provider.of<AppData>(context,listen: context).UpdatePickUpLocationAddress(userPickUpAddress);


    }
    return placeAdress;

//now we call this function in app


  }
}