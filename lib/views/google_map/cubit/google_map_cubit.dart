import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/type/enum.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/map/map_repository.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  final MapRepository _mapRepository;
  GoogleMapCubit({required MapRepository mapRepository}) :
       _mapRepository = mapRepository, super( const GoogleMapState());


  void loadingAddressFromUser(String address){
    emit(state.copyWith(address: address,status: StatusType.loaded,errorMessage: ""));
  }

  void getPositionLocation(LatLng newPosition) async {
    try{
      emit(state.copyWith(status: StatusType.loading,errorMessage: "Loading"));
      await Future<void>.delayed(const Duration(seconds: 5));
      String getLocation = await _mapRepository.getLocation(newPosition);
      if(getLocation.contains("Fail")){
        emit(state.copyWith(status: StatusType.error,errorMessage: getLocation));
      }else{
        emit(state.copyWith(position: newPosition,status: StatusType.loaded,errorMessage: "Địa chỉ: $getLocation",address: getLocation));
      }
    }catch(error){
      emit(state.copyWith(status: StatusType.error,errorMessage: "Error"));
    }

  }

  void changeLocation(String text){
    String newLocation = "$text,${state.address}";
    emit(state.copyWith(address: newLocation));
    rebuildStatus();
  }


  void rebuildStatus(){
    emit(state.copyWith(status: StatusType.loading));
    emit(state.copyWith(status: StatusType.loaded));
  }

}
