import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/style/app_assets.dart';
import 'package:education_children/feature/island/model/plan_model.dart';
import 'package:education_children/feature/island/payment_screen.dart';
import 'package:education_children/feature/island/widget/subscription_widgets.dart';
import 'package:flutter/material.dart';


class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int _selected = 1; // "طفلان" is the most popular

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocale.textDirection,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.subscriptionBg, fit: BoxFit.cover),
            SafeArea(
              child: Column(
                children: [
                  SubscriptionTopBar(title: 'subscriptions'.tr()),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                      children: [
                        for (var i = 0; i < plans.length; i++)
                          _PlanCard(
                            plan: plans[i],
                            selected: i == _selected,
                            onTap: () => setState(() => _selected = i),
                          ),
                        const _FeaturesCard(),
                        const SizedBox(height: 16),
                        const _InfoCard(),
                        const SizedBox(height: 16),
                        const _ContactCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Fixed subscribe button
            Positioned(
              left: 16,
              right: 16,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SubscribeButton(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(plan: plans[_selected]),
                      ),
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

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final bool selected;
  final VoidCallback onTap;
  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 22, top: plan.popular ? 14 : 0),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: plan.color.withOpacity(selected ? 1 : .45),
                  width: selected ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFDDE9FB), width: 4),
                    ),
                    child: ClipOval(
                      child: Image.asset(plan.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: plan.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      plan.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plan.subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  for (final f in plan.features) _FeatureRow(text: f),
                  if (plan.highlight != null)
                    _FeatureRow(
                      text: plan.highlight!,
                      color: const Color(0xFFE8590C),
                      bold: true,
                    ),
                  const SizedBox(height: 14),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${plan.price}',
                          style: const TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' ريال',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    style: TextStyle(color: plan.color),
                  ),
                  if (plan.oldPrice != null)
                    Text(
                      'بدل ${plan.oldPrice} ريال',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
            ),
            if (plan.popular)
              Positioned(
                top: -14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9A3C),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '⭐ الأكثر اختياراً ⭐',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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

class _FeatureRow extends StatelessWidget {
  final String text;
  final Color color;
  final bool bold;
  const _FeatureRow({
    required this.text,
    this.color = const Color(0xFF1B1B3A),
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check, color: Color(0xFF2E9A3D), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: color,
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  const _FeaturesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              _FeatureTile(
                icon: Icons.bar_chart_rounded,
                bg: Color(0xFFFFEBDD),
                iconColor: Color(0xFFE8590C),
                title: 'تقارير مفصلة',
                subtitle: 'لمتابعة تقدم كل طفل',
              ),
              _FeatureTile(
                icon: Icons.card_giftcard_rounded,
                bg: Color(0xFFFDE7EF),
                iconColor: Color(0xFFE0457B),
                title: 'محتوى متجدد',
                subtitle: 'دروس وألعاب جديدة باستمرار',
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              _FeatureTile(
                icon: Icons.groups_rounded,
                bg: Color(0xFFE3EEFF),
                iconColor: Color(0xFF3B6FD8),
                title: 'ملفات منفصلة',
                subtitle: 'لكل طفل تجربة مخصصة',
              ),
              _FeatureTile(
                icon: Icons.verified_user_rounded,
                bg: Color(0xFFE6F7EC),
                iconColor: Color(0xFF2E9A3D),
                title: 'دفع آمن 100%',
                subtitle: 'حماية بياناتك ومعاملاتك',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color iconColor;
  final String title;
  final String subtitle;
  const _FeatureTile({
    required this.icon,
    required this.bg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: SubColors.navy),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  static const _items = [
    'الاشتراك يتجدد تلقائياً ما لم يتم إلغاؤه.',
    'يمكنك ترقية أو تغيير الباقة في أي وقت من الإعدادات.',
    'جميع الأسعار شاملة ضريبة القيمة المضافة.',
  ];

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F55C8);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 22,
                backgroundColor: blue,
                child: Text('؟',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 12),
              Text(
                'معلومات مهمة',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SubColors.navy),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final t in _items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(t,
                        style: const TextStyle(color: blue, fontSize: 14)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8DC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFE58F)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: SubColors.yellow,
            child: Icon(Icons.support_agent_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'لأي استفسار أو مساعدة، تواصل معنا',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: SubColors.navy),
                ),
                SizedBox(height: 4),
                Text(
                  'نحن هنا لمساعدتك دائماً 💛',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscribeButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SubscribeButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0xFFD99A00), offset: Offset(0, 4)),
          ],
        ),
        child: const Text(
          'اشترك الآن 🙏',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}