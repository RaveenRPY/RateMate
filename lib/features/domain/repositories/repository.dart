import 'package:dartz/dartz.dart';
import 'package:ratemate/features/data/models/exchange_rate_response.dart';

abstract class Repository {
  Future<Either<Exception, ExchangeRateResponse>> getRates(
      String baseCode);
}