import 'package:dartz/dartz.dart';
import 'package:ratemate/features/data/models/exchange_rate_response.dart';

import '../../domain/repositories/repository.dart';
import '../datasources/remote_data_source.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSourceImpl? remoteDataSource = RemoteDataSourceImpl();

  @override
  Future<Either<Exception, ExchangeRateResponse>> getRates(
      String baseCode) async {
    try {
      final parameters = await remoteDataSource!.getRates(baseCode);
      return Right(parameters);
    } catch (e) {
      return Left(Exception());
    }
  }
}
