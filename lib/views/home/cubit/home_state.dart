part of 'home_cubit.dart';

class HomeState extends Equatable{
   final int currentIndex;
  const HomeState({this.currentIndex = 0});

  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];

}