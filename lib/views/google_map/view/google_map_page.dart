import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_small_bloc/views/google_map/cubit/google_map_cubit.dart';

import '../../account/cubit/account_cubit.dart';
import '../../widget/show_dialog.dart';
import '../../widget/show_snack_bar.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key, this.locationLatlng,}) : super(key: key);

  final LatLng? locationLatlng;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  late GoogleMapController googleMapController;

  CameraPosition initialCameraPosition = const CameraPosition(target:  LatLng(10.5881982,106.5937773), zoom: 14);


  Set<Marker> markers = {};
  late LatLng locationLatLng;
  String _currentAddress = "null";
  late LatLng position;


  @override
  void initState() {
    _initLocation();
    super.initState();
  }

  Future<void> _initLocation() async{
    if(widget.locationLatlng == null){
      Position initPosition = await GeolocatorPlatform.instance
          .getCurrentPosition();
      locationLatLng = LatLng(initPosition.latitude,initPosition.longitude);
      position = locationLatLng;

    }else{
      locationLatLng = widget.locationLatlng!;
      position = widget.locationLatlng!;
    }
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: locationLatLng));
    setState((){

    });
  }


  @override
  Widget build(BuildContext context) {
    print("rebuild widget googlemap page");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My location"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
            /* BlocProvider.of<HomeBloc>(context)
                  .add(SetLocationEvent(locationLatLng: locationLatLng,myLocation: _currentAddress));
              Navigator.pop(context);*/

          },
        ),
        centerTitle: true,

      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onCameraMove: (CameraPosition newPosition) async{
              locationLatLng = newPosition.target;

            },
          ),

          const Center(
              child: Icon(Icons.location_pin,color: Colors.blue,size: 35,))

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
                await getNewPosition().whenComplete((){
                context.read<GoogleMapCubit>().getPositionLocation(position);
              });
          },
          label: const Text("Get Location"),
          icon: const Icon(Icons.edit_location_outlined)),
    );
  }

  Future<void> getNewPosition()async{
    position = await _determinePosition(locationLatLng);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(
            position.latitude,position.longitude
        ),zoom: 14)));

    markers.clear();
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(
        position.latitude,position.longitude
    )));
  }

  Future<LatLng> _determinePosition(LatLng position) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }


    return position;
  }

}
