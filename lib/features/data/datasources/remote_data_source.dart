import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ratemate/features/data/models/exchange_rate_response.dart';

abstract class RemoteDataSource {
  Future<ExchangeRateResponse> getRates(String baseCode);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio? dio = Dio();

  @override
  Future<ExchangeRateResponse> getRates(String baseCode) async {
    try {
      final response = await dio!.get("https://v6.exchangerate-api.com/v6/c38048955022558f25e07968/latest/$baseCode");
      log(response.data.toString());
      return ExchangeRateResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }
}
