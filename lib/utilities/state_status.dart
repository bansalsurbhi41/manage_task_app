import 'package:equatable/equatable.dart';

abstract class StateStatus extends Equatable {
  const StateStatus();
  @override
  List<Object> get props => [];
}

class StateNotLoaded extends StateStatus {
  const StateNotLoaded();
}

class StateLoading extends StateStatus {

}

class StateLoaded extends StateStatus {

  const StateLoaded();
  @override
  List<Object> get props => [];
}

class StateFailed extends StateStatus {


  const StateFailed();
  @override
  List<Object> get props => [];
}
