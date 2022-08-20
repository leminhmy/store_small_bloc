import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeIndex(int index) {
    emit(HomeState(currentIndex: index));
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference myRef = database.ref("counter");
    myRef.set("Hello world $index");

  }
}
