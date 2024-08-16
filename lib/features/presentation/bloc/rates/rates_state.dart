part of 'rates_bloc.dart';

abstract class RatesState {}

class RatesInitial extends RatesState {}

class APILoadingState extends RatesState {}

class GetRatesSuccessState extends RatesState {
  final RatesEntity? ratesEntity;

  GetRatesSuccessState({this.ratesEntity});
}

class GetRatesFailedState extends RatesState {
  final String? result;
  final String? errorType;

  GetRatesFailedState({this.result, this.errorType});
}
