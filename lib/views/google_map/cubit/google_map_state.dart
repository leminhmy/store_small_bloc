part of 'google_map_cubit.dart';

class GoogleMapState extends Equatable{
  final String errorMessage;
  final StatusType status;
  final LatLng? position;
  final String address;

  const GoogleMapState({this.address = "",this.position,this.errorMessage = "",this.status = StatusType.init});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage,status,position,address];

  GoogleMapState copyWith({String? errorMessage,StatusType? status, LatLng? position,String? address}){
    return GoogleMapState(
      status: status??this.status,
      errorMessage: errorMessage??this.errorMessage,
      position: position??this.position,
      address: address??this.address,
    );
  }

}