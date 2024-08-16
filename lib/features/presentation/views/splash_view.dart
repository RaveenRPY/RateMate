import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratemate/features/presentation/bloc/rates/rates_bloc.dart';
import 'package:ratemate/features/presentation/views/conversion_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    BlocProvider.of<RatesBloc>(context).add(RatesRequestEvent(baseCode: 'USD'));
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
        if(state is GetRatesSuccessState){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ConversionView(),
          ));
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'RateMate',
            style: GoogleFonts.poppins(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
