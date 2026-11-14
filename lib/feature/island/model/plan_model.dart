import 'package:education_children/core/style/app_assets.dart';
import 'package:flutter/material.dart';

class PlanModel {
  final String title;
  final String subtitle;
  final String image;
  final Color color;
  final List<String> features;
  final String? highlight; // e.g. 'توفير أفضل'
  final int price;
  final int? oldPrice;
  final bool popular;

  const PlanModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
    required this.features,
    required this.price,
    this.highlight,
    this.oldPrice,
    this.popular = false,
  });
}

const plans = <PlanModel>[
  PlanModel(
    title: 'طفل واحد',
    subtitle: 'مناسب لطفل واحد',
    image: AppAssets.kidOne,
    color: Color(0xFF4285F4),
    features: [
      'جميع الجزر والدروس',
      'جميع الألعاب والبازل',
      'الاختبارات وجزيرة الكنز',
      'متابعة تقدم الطفل',
    ],
    price: 49,
  ),
  PlanModel(
    title: 'طفلان',
    subtitle: 'مناسب لطفلين',
    image: AppAssets.kidTwo,
    color: Color(0xFFFF9A3C),
    features: [
      'جميع المميزات',
      'إنشاء حسابين للأطفال',
      'متابعة كل طفل بشكل منفصل',
      'تقارير لكل طفل',
    ],
    highlight: 'توفير أفضل',
    price: 89,
    oldPrice: 99,
    popular: true,
  ),
  PlanModel(
    title: '3 أطفال',
    subtitle: 'مناسب ل3 أطفال',
    image: AppAssets.kidThree,
    color: Color(0xFF9333EA),
    features: [
      'جميع المميزات',
      'إنشاء 3 حسابات للأطفال',
      'متابعة كل طفل بشكل منفصل',
      'تقارير لكل طفل',
    ],
    highlight: 'توفير أفضل',
    price: 179,
  ),
];