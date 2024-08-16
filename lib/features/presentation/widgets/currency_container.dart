import 'package:country_flags/country_flags.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratemate/utils/app_utils.dart';

class CurrencyContainer extends StatefulWidget {
  bool? isBaseCurrency;
  TextEditingController? controller;
  String? initialValue;
  String? currencyCode;

  CurrencyContainer(
      {super.key,
      this.isBaseCurrency,
      this.controller,
      this.initialValue,
      this.currencyCode});

  @override
  State<CurrencyContainer> createState() => _CurrencyContainerState();
}

class _CurrencyContainerState extends State<CurrencyContainer> {
  String? countryCode;
  String? currencyCode;
  String? amount;

  @override
  void initState() {
    setState(() {
      currencyCode = widget.currencyCode ?? 'LKR';
      countryCode = AppUtils.currency2CountryCode(currencyCode!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      onTapOutside: (PointerDownEvent event) {
        FocusScope.of(context).unfocus();
      },
      initialValue: widget.initialValue,
      cursorColor: Colors.green,
      style: GoogleFonts.poppins(fontSize: 18),
      decoration: InputDecoration(
        enabled: widget.isBaseCurrency ?? false,
        contentPadding: const EdgeInsets.fromLTRB(20, 20,10,20),
        filled: true,
        fillColor: const Color(0xff262425),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: widget.initialValue ?? '0.00',
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
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Colors.grey,
                    )
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
                      countryCode = AppUtils.currency2CountryCode(currencyCode!);
                    });
                  },
                  theme: CurrencyPickerThemeData(
                    flagSize: 25,
                    titleTextStyle: const TextStyle(fontSize: 17),
                    subtitleTextStyle: TextStyle(
                        fontSize: 15, color: Theme.of(context).hintColor),
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
                    //Optional. Styles the search field.
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
