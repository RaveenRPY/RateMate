import 'package:country_flags/country_flags.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratemate/utils/app_constants.dart';
import 'package:ratemate/utils/app_styles.dart';
import 'package:ratemate/utils/app_utils.dart';

class CurrencyContainer extends StatefulWidget {
  bool? isBaseCurrency;
  String? amount2Convert;
  TextEditingController? controller;
  String? initialValue;
  String? currencyCode;
  final ValueChanged<String>? onAmountChanged;

  CurrencyContainer({
    super.key,
    this.isBaseCurrency = false,
    this.amount2Convert,
    this.controller,
    this.initialValue,
    this.currencyCode,
    this.onAmountChanged,
  });

  @override
  State<CurrencyContainer> createState() => _CurrencyContainerState();
}

class _CurrencyContainerState extends State<CurrencyContainer> {
  String? countryCode;
  String? currencyCode;
  late TextEditingController controller;
  late double rateFactor;

  @override
  void initState() {
    super.initState();
    currencyCode = widget.currencyCode ?? 'LKR';
    countryCode = AppUtils.currency2CountryCode(currencyCode!);
    controller = widget.controller ?? TextEditingController();
    controller.addListener(_onControllerChanged);

    rateFactor = AppConstants.ratesMap[currencyCode]!;
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    if (!widget.isBaseCurrency!) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onControllerChanged() {
    if (widget.onAmountChanged != null) {
      widget.onAmountChanged!(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.isBaseCurrency! ? controller : null,
      cursorColor: Colors.green,
      keyboardType: TextInputType.number,
      style: AppStyling.bold20White(),
      onChanged: (amount) {
        _onControllerChanged();
      },
      onTapOutside: (PointerDownEvent p){FocusScope.of(context).unfocus();},
      decoration: InputDecoration(
        enabled: widget.isBaseCurrency ?? false,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        filled: true,
        hintStyle: AppStyling.bold20White(),
        fillColor: const Color(0xff262425),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: widget.initialValue == '' || widget.initialValue == null
            ? '0.0'
            : ((double.parse(widget.initialValue!) * rateFactor).toStringAsFixed(2)).toString(),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 1.5),
            borderRadius: BorderRadius.circular(15)),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountryFlag.fromCountryCode(
                      countryCode ?? 'LK',
                      height: 18,
                      width: 18,
                      shape: const Circle(),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      currencyCode!,
                      style: AppStyling.medium14White(),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onTap: () {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showSearchField: true,
                  showCurrencyName: true,
                  favorite: ['lkr'],
                  onSelect: (Currency currency) {
                    setState(() {
                      currencyCode = currency.code;
                      countryCode =
                          AppUtils.currency2CountryCode(currencyCode!);
                    });
                  },
                  currencyFilter: AppConstants.currencyList,
                  theme: CurrencyPickerThemeData(
                    flagSize: 25,
                    titleTextStyle: AppStyling.medium16White(),
                    subtitleTextStyle: AppStyling.thin14Grey().copyWith(color: Theme.of(context).hintColor),
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
