
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:money2/money2.dart';

class AppUtils {
  static String currency2CountryCode(String currencyCode) {
    final currency = Currencies().find(currencyCode);

    Country selectedDialogCurrency =
        CountryPickerUtils.getCountryByCurrencyCode(currency!.isoCode);

    return selectedDialogCurrency.isoCode!;
  }
}
