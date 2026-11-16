import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/state/subscription_state.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocale.textDirection,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.successBg, fit: BoxFit.cover),

            // Kid on the boat
            Positioned(
              left: -10,
              right: -20,
              bottom: 30,
              child: IgnorePointer(
                child: Image.asset(AppAssets.boatKid, fit: BoxFit.fitWidth),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36, 50, 36, 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          backgroundColor: Color(0xFF4CAF50),
                          child: Icon(Icons.check_rounded,
                              color: Colors.white, size: 64),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'تم تفعيل اشتراكك بنجاح!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3FA845),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'أصبحت جميع الجزر متاحة لك الآن استمتع\nبرحلتك التعليمية',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF2A3FB5),
                          ),
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              isSubscribed.value = true; // unlock all islands
                              Navigator.of(context)
                                  .popUntil((r) => r.isFirst);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(.55),
                              foregroundColor: const Color(0xFF2F4FD8),
                              side: const BorderSide(
                                  color: Color(0xFF2F4FD8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'اذهب للخريطة',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}