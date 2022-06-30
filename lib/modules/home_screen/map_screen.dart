import 'dart:collection';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class HomeScreen extends StatefulWidget {
  late  double latitude,longitude;
  late  String name;

  HomeScreen({Key? key, required String latitude,required String longitude,required String name}) : super(key: key) {
    this.latitude = double.parse(latitude);
    this.longitude = double.parse(longitude);
    this.name = name;
  }


  @override
  _HomeScreenState createState() => _HomeScreenState(longitude: longitude, latitude: latitude,name: name);
}

class _HomeScreenState extends State<HomeScreen> {
   late double latitude,longitude;
   late  String name;

  

   _HomeScreenState({Key? key, required double latitude,required double longitude,required String name})  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.name = name;

  }

  

  var myMarkers= HashSet<Marker>(); //collection
  Set<Polygon> myPolygon() {
    var polygonCords =  <LatLng>[];
    polygonCords.add( LatLng(latitude, longitude));
    polygonCords.add( MainCubit.get(context).latLng!);


    var polygonSet = <Polygon>{};
    polygonSet.add(Polygon(
        polygonId: const PolygonId('1'),
        points: polygonCords,
         strokeColor: Colors.blueAccent,

    ));

    return polygonSet;
  }
  Function(GoogleMapController)?  googleMapController(){

      myMarkers.add( Marker(
        markerId: const MarkerId('1'),
        position:  LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: name,
          snippet: '',
          onTap: (){
            setState(() {
              print('marker tabed');

            });
          },

        ),

      ),);
      myMarkers.add( Marker(markerId: const MarkerId('3'),
          position:MainCubit.get(context).latLng!,
          icon: BitmapDescriptor.defaultMarkerWithHue(240.0),
      ),);

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 50,
        leading: IconButton(icon:const Icon(IconBroken.Arrow___Left) ,onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
            const Text('issing ',),
          ],),
        centerTitle: true,
      ),
      body:   ConditionalBuilder(
        condition: MainCubit.get(context).latLng != null ,
        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        builder: (BuildContext context) =>GoogleMap(
          polygons: myPolygon(),
          mapType: MapType.normal,

          initialCameraPosition:  CameraPosition(
              target: MainCubit.get(context).latLng!, zoom: 6),
          onMapCreated:googleMapController(),
          markers: myMarkers,

    // const GoogleMap(
    //
    // mapType: MapType.normal,
    //
    // initialCameraPosition:  CameraPosition(
    // target: LatLng(30.592360596253698,32.283182649650485), zoom: 8),
    //
    //
    //
    // ),

        ),
      ),
    );
  },
);
  }
}
