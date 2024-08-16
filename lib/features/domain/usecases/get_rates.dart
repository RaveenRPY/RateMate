import 'package:dartz/dartz.dart';
import 'package:ratemate/features/data/models/exchange_rate_response.dart';
import 'package:ratemate/features/data/repositories/repository_impl.dart';

class GetRates {
  RepositoryImpl? repository = RepositoryImpl();

  @override
  Future<Either<Exception, ExchangeRateResponse>> call(String params) async {
    return await repository!.getRates(params);
  }
}
