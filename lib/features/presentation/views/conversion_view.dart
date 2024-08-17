import 'dart:developer';
import 'dart:ui';

import 'package:country_currency_pickers/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ratemate/features/data/datasources/local_data_source.dart';
import 'package:ratemate/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ratemate/utils/app_styles.dart';
import 'package:ratemate/utils/app_utils.dart';

import '../../../utils/app_constants.dart';
import '../widgets/currency_container.dart';
import '../widgets/custom_dialog_box.dart';

class ConversionView extends StatefulWidget {
  const ConversionView({super.key});

  @override
  State<ConversionView> createState() => _ConversionViewState();
}

class _ConversionViewState extends State<ConversionView> {
  String? currencyCode;
  String? countryCode;
  double mainAmount = 0;

  bool _isProgressShow = false;
  final LocalDataSource localDataSource = LocalDataSource();

  TextEditingController mainAmountController = TextEditingController();

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
                    onCurrencyChanged: (currency) {
                      setState(() {});
                    },
                    onAmountChanged: (amount) {
                      setState(() {
                        mainAmount = double.tryParse(amount) ?? 0.0;
                      });
                      log("Main Amount: $mainAmount");
                    },
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'CONVERT TO :',
                    style: AppStyling.thin14Grey(),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemCount: AppConstants.converterList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
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
                                  setState(() {
                                    AppConstants.converterList.removeAt(index);
                                    localDataSource.setLocalConvertors(
                                        AppConstants.converterList);
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: CurrencyContainer(
                              key: UniqueKey(),
                              currencyCode: AppConstants.converterList[index],
                              initialValue: mainAmountController.text,
                              onCurrencyChanged: (currency) {
                                setState(() {
                                  AppConstants.converterList[index] = currency;
                                  localDataSource.setLocalConvertors(
                                      AppConstants.converterList);
                                });
                              },
                              onAmountChanged: (amount) {
                                setState(() {
                                  mainAmount = double.tryParse(amount) ?? 0.0;
                                });
                                log("Updated Amount: $mainAmount");
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          AppConstants.converterList.add('LKR');
                          localDataSource
                              .setLocalConvertors(AppConstants.converterList);
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
