import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/island/model/plan_model.dart';
import 'package:education_children/feature/island/success_screen.dart';
import 'package:education_children/feature/island/widget/subscription_widgets.dart';
import 'package:flutter/material.dart';


class PaymentScreen extends StatefulWidget {
  final PlanModel plan;
  const PaymentScreen({super.key, required this.plan});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selected = 0;

  static const _methods = [
    ('فيزا', AppAssets.visa),
    ('ماستر كارد', AppAssets.masterCard),
  ];

  void _onContinue() {
    // TODO: connect the real payment gateway here (widget.plan.price)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocale.textDirection,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.paymentBg, fit: BoxFit.cover),
            SafeArea(
              child: Column(
                children: [
                  SubscriptionTopBar(title: 'subscriptions'.tr()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      children: [
                        for (var i = 0; i < _methods.length; i++)
                          _MethodTile(
                            name: _methods[i].$1,
                            logo: _methods[i].$2,
                            selected: i == _selected,
                            onTap: () => setState(() => _selected = i),
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: NavyButton(text: 'متابعة', onPressed: _onContinue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String name;
  final String logo;
  final bool selected;
  final VoidCallback onTap;
  const _MethodTile({
    required this.name,
    required this.logo,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        margin: const EdgeInsets.only(bottom: 22),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: selected
              ? Border.all(color: SubColors.navy, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(logo, width: 50, height: 32, fit: BoxFit.contain),
            const SizedBox(width: 18),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: SubColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}