import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(context)=>BlocProvider.of(context);

  LocationData? currentLocation;
  LatLng? latLng ;
  bool isLatLng = false;
  justEmitState(){
    emit(MapLocationSuccessState());

  }

  getLocation({required BuildContext context,required String longitude,required String latitude, }) async {

    var location = Location();


    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);

      latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      justEmitState();
      print("getLocation:$latLng");
      print("getLocation:$isLatLng");
      isLatLng = true;

    });





  }


}
