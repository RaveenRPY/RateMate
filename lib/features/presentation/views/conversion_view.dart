import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_flags/country_flags.dart';
import 'package:money2/money2.dart' as money2;
import 'package:ratemate/utils/app_utils.dart';

import '../widgets/currency_container.dart';

class ConversionView extends StatefulWidget {
  const ConversionView({super.key});

  @override
  State<ConversionView> createState() => _ConversionViewState();
}

class _ConversionViewState extends State<ConversionView> {
  String currencyCode = 'LKR';
  String? countryCode;

  @override
  void initState() {
    setState(() {
      countryCode = AppUtils.currency2CountryCode(currencyCode);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advanced Exchanger',
          style: GoogleFonts.poppins(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                'INSERT AMOUNT :',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              const SizedBox(height: 15),
              CurrencyContainer(
                isBaseCurrency: true,
              ),
              const SizedBox(height: 40),
              Text(
                'CONVERT TO :',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              const SizedBox(height: 15),
              CurrencyContainer(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                        surfaceTintColor:
                            WidgetStatePropertyAll(Color(0xff69b336))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Color(0xff69b336),
                        ),
                        Text(
                          'Add Converter',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff69b336)),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
