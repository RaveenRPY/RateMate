import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ratemate/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ratemate/features/presentation/widgets/custom_dialog_box.dart';
import 'package:ratemate/utils/app_styles.dart';
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
  double mainAmount = 0;

  bool _isProgressShow = false;

  TextEditingController mainAmountController = TextEditingController();

  List<CurrencyContainer> currencyContainers = [];

  @override
  void initState() {
    super.initState();
    countryCode = AppUtils.currency2CountryCode(currencyCode);
    currencyContainers.add(
      CurrencyContainer(
        currencyCode: 'LKR',
        onAmountChanged: (amount) {},
        initialValue: mainAmountController.text, // Initialize delete callback
      ),
    );
    mainAmountController.addListener(_updateCurrencyContainers);
  }

  @override
  void dispose() {
    mainAmountController.removeListener(_updateCurrencyContainers);
    super.dispose();
  }

  void _updateCurrencyContainers() {
    setState(() {
      currencyContainers = currencyContainers.map((container) {
        return CurrencyContainer(
          currencyCode: container.currencyCode,
          onAmountChanged: container.onAmountChanged,
          initialValue: mainAmountController.text,// Pass delete callback
        );
      }).toList();
    });
  }

  void _removeCurrencyContainer(int index) {
    setState(() {
      if (index >= 0 && index < currencyContainers.length) {
        currencyContainers.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatesBloc, RatesState>(
      listener: (context, state) {
        if (state is APILoadingState) {
          showProgress();
        } else if (state is GetRatesSuccessState) {
          hideProgressBar();
        }
      },
      child: Scaffold(
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
                  const SizedBox(height: 40),
                  Text(
                    'INSERT AMOUNT :',
                    style: AppStyling.thin14Grey(),
                  ),
                  const SizedBox(height: 15),
                  CurrencyContainer(
                    isBaseCurrency: true,
                    currencyCode: 'USD',
                    controller: mainAmountController,
                    onAmountChanged: (amount) {
                      setState(() {
                        mainAmount = double.tryParse(amount) ?? 0;
                        _updateCurrencyContainers();
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'CONVERT TO :',
                    style: AppStyling.thin14Grey(),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: currencyContainers.asMap().entries.map((entry) {
                      int index = entry.key;
                      CurrencyContainer container = entry.value;
                      return GestureDetector(
                        onLongPress: () {
                          CustomDialogBox.show(
                            context,
                            isTwoButton: true,
                            message: 'Are you sure to delete?',
                            negativeButtonText: 'No',
                            positiveButtonText: 'Yes',
                            negativeButtonTap: () {
                              Navigator.pop(context);
                            },
                            positiveButtonTap: () {
                              _removeCurrencyContainer(index);
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Column(
                          children: [
                            container,
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currencyContainers.add(
                            CurrencyContainer(
                              currencyCode: 'LKR',
                              onAmountChanged: (amount) {},
                              initialValue: mainAmountController.text,
                            ),
                          );
                        });
                      },
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20)),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showProgress() {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    alignment: FractionalOffset.center,
                    child: Container(
                        color: Colors.transparent,
                        height: 120,
                        width: 120,
                        child: Lottie.asset('assets/lottie/api_loading.json')),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Container();
        },
      );
    }
  }

  void hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }
}
