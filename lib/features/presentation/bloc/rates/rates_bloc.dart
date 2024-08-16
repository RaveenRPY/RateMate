import 'package:bloc/bloc.dart';
import 'package:ratemate/features/data/datasources/remote_data_source.dart';
import 'package:ratemate/features/domain/entities/rates_entity.dart';
import 'package:ratemate/features/domain/usecases/get_rates.dart';

part 'rates_event.dart';

part 'rates_state.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final GetRates? useCaseGetRates = GetRates();
  RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();

  RatesBloc() : super(RatesInitial()) {
    on<RatesRequestEvent>(_handleRatesRequestEvent);
  }

  Future<void> _handleRatesRequestEvent(
      RatesRequestEvent event, Emitter<RatesState> emit) async {
    emit(APILoadingState());

    final result = await remoteDataSourceImpl.getRates(event.baseCode!);

    emit(
     GetRatesSuccessState(
    ratesEntity: RatesEntity(
    conversionRates: result.conversionRates,
    baseCode: result.baseCode,
    ),
    )
      // result.fold(
      //   (l) {
      //     return GetRatesFailedState();
      //   },
      //   (r) {
      //     return GetRatesSuccessState(
      //       ratesEntity: RatesEntity(
      //         conversionRates: r.conversionRates,
      //         baseCode: r.baseCode,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
