part of 'rates_bloc.dart';

abstract class RatesEvent {}

class RatesRequestEvent extends RatesEvent {
  String? baseCode;

  RatesRequestEvent({this.baseCode});
}

class GetLocalConvertorsEvent extends RatesEvent {}
