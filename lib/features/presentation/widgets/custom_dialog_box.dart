import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:ratemate/utils/app_styles.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    super.key,
    this.title,
    this.image,
    this.isTwoButton = true,
    this.negativeButtonText,
    this.positiveButtonText,
    this.negativeButtonTap,
    this.positiveButtonTap,
    this.messege,
  });

  final String? title;
  final String? messege;
  final String? image;
  final bool isTwoButton;
  final String? negativeButtonText;
  final String? positiveButtonText;
  final Function? negativeButtonTap;
  final Function? positiveButtonTap;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.all(20),
        child: Material(
          color: const Color(0xff2e3627),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          child: Wrap(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.8.h, horizontal: 2.6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        image ?? 'assets/lottie/q1.json',
                        frameRate: const FrameRate(120),
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      title ?? '',
                      style: AppStyling.medium16White(),
                    ),
                    if (title != null && title == '')
                      const SizedBox(height: 10)
                    else
                      const SizedBox.shrink(),
                    Text(
                      messege ?? '',
                      textAlign: TextAlign.center,
                      style:
                          AppStyling.thin14Grey().copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        if (isTwoButton)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                negativeButtonTap!();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.grey.withOpacity(0.5))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                child: Text(
                                  negativeButtonText ?? '',
                                  style: AppStyling.bold16White(),
                                ),
                              ),
                            ),
                          ),
                        if (isTwoButton) SizedBox(width: 2.5.w),
                        Expanded(
                          child: ElevatedButton(

                            onPressed: () {
                              positiveButtonTap!();
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Color(0xff69b336))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text(
                                positiveButtonText ?? '',
                                style: AppStyling.bold16White().copyWith(color: Color(
                                    0xff213911)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    String? title,
    String? message,
    String? image,
    bool isTwoButton = true,
    String? negativeButtonText,
    String? positiveButtonText,
    VoidCallback? negativeButtonTap,
    VoidCallback? positiveButtonTap,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: CustomDialogBox(
              title: title,
              messege: message,
              image: image,
              negativeButtonText: negativeButtonText,
              positiveButtonText: positiveButtonText,
              negativeButtonTap: negativeButtonTap,
              positiveButtonTap: positiveButtonTap,
              isTwoButton: isTwoButton,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return const SizedBox.shrink();
      },
    );
  }
}
