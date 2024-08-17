import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ratemate/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ratemate/features/presentation/views/conversion_view.dart';
import 'package:ratemate/features/presentation/widgets/custom_dialog_box.dart';
import 'package:ratemate/utils/app_constants.dart';
import 'package:ratemate/utils/app_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    BlocProvider.of<RatesBloc>(context).add(RatesRequestEvent(baseCode: 'USD'));
    BlocProvider.of<RatesBloc>(context).add(GetLocalConvertorsEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatesBloc, RatesState>(
      listener: (context, state) {
        if (state is GetRatesSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ConversionView(),
          ));
        } else if (state is GetLocalConvertersSuccessState) {
          setState(() {
            AppConstants.converterList = state.local ?? [];
          });
        } else if (state is GetRatesFailedState) {
          CustomDialogBox.show(
            context,
            isTwoButton: false,
            title: 'Oops..!',
            message: 'Something went wrong',
            image: 'assets/lottie/failedError.json',
            positiveButtonText: 'Try again',
            positiveButtonTap: () {
              BlocProvider.of<RatesBloc>(context)
                  .add(RatesRequestEvent(baseCode: 'USD'));
              Navigator.pop(context);
            },
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 160,
                  child: Lottie.asset('assets/lottie/splash1.json')),
              const SizedBox(height: 10),
              Text(
                'RateMate',
                style: AppStyling.medium30White(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
