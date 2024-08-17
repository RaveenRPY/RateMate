import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ratemate/features/data/datasources/local_data_source.dart';
import 'package:ratemate/features/data/datasources/remote_data_source.dart';
import 'package:ratemate/features/domain/entities/rates_entity.dart';
import 'package:ratemate/features/domain/usecases/get_rates.dart';
import 'package:ratemate/utils/app_constants.dart';

import '../../../data/repositories/repository_impl.dart';

part 'rates_event.dart';

part 'rates_state.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final GetRates? useCaseGetRates = GetRates();
  final LocalDataSource? localDataSource = LocalDataSource();

  RatesBloc() : super(RatesInitial()) {
    on<RatesRequestEvent>(_handleRatesRequestEvent);
    on<GetLocalConvertorsEvent>(_getLocalConvertersEvent);
  }

  Future<void> _handleRatesRequestEvent(
      RatesRequestEvent event, Emitter<RatesState> emit) async {
    emit(APILoadingState());

    final result = await useCaseGetRates!(event.baseCode!);

    emit(
      result.fold(
        (l) {
          return GetRatesFailedState();
        },
        (r) {
          AppConstants.currencyList = r.conversionRates!.keys.toList();
          AppConstants.ratesMap = r.conversionRates!;

          return GetRatesSuccessState(
            ratesEntity: RatesEntity(
              conversionRates: r.conversionRates,
              baseCode: r.baseCode,
            ),
          );
        },
      ),
    );
  }

  Future<void> _getLocalConvertersEvent(
      GetLocalConvertorsEvent event, Emitter<RatesState> emit) async {

    emit(APILoadingState());

    try {
      final locals = await localDataSource!.getLocalConvertors();

      emit(GetLocalConvertersSuccessState(local: locals));
    } catch (e) {
      rethrow;
    }
  }
}
