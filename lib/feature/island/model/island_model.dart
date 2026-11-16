import 'package:education_children/core/localization/app_locale.dart';
import 'package:education_children/core/style/app_assets.dart';

class IslandModel {
  final String title;
  final String? titleKey;
  final String image;
  final double x; // island center as a fraction of width
  final double y; // island center as a fraction of height
  final double size; // island tap zone width as a fraction of screen width
  final double pillX; // pill center as fraction of screen width
  final double pillY; // pill center as fraction of base map height
  final double arrowX; // arrow center as fraction of screen width
  final double arrowY; // arrow center as fraction of base map height
  final double labelBottom;
  final bool locked;

  const IslandModel({
    required this.title,
    this.titleKey,
    required this.image,
    required this.x,
    required this.y,
    required this.size,
    required this.pillX,
    required this.pillY,
    this.arrowX = 0.5,
    this.arrowY = 0.5,
    this.labelBottom = 0.0,
    this.locked = true,
  });

  String get displayTitle => titleKey != null ? titleKey!.tr() : title;

  IslandModel copyWith({bool? locked}) => IslandModel(
        title: title,
        titleKey: titleKey,
        image: image,
        x: x,
        y: y,
        size: size,
        pillX: pillX,
        pillY: pillY,
        arrowX: arrowX,
        arrowY: arrowY,
        labelBottom: labelBottom,
        locked: locked ?? this.locked,
      );
}

/// إحداثيات الجزر الستة بالدقة المطلقة مطابقة تماماً لصورة التصميم الأصلية (Figma)
const islands = <IslandModel>[
  IslandModel(
    title: 'جزيرة الحروف',
    titleKey: 'island_letters',
    image: AppAssets.lettersIsland,
    x: 0.303, // 119 / 393
    y: 0.300, // 287 / 956
    size: 0.44,
    pillX: 0.3015, // 118.5 / 393
    pillY: 0.3285, // 314 / 956
    arrowX: 0.3104, // 122 / 393
    arrowY: 0.1820, // 174 / 956
    locked: false,
  ),
  IslandModel(
    title: 'جزيرة الحركات',
    titleKey: 'island_diacritics',
    image: AppAssets.harakatIsland,
    x: 0.776, // 305 / 393
    y: 0.380, // 363 / 956
    size: 0.44,
    pillX: 0.7532, // 296 / 393
    pillY: 0.4310, // 412 / 956
    arrowX: 0.7506, // 295 / 393
    arrowY: 0.2678, // 256 / 956
    locked: true,
  ),
  IslandModel(
    title: 'جزيرة حروف المد',
    titleKey: 'island_long_vowels',
    image: AppAssets.maddIsland,
    x: 0.300, // 118 / 393
    y: 0.485, // 464 / 956
    size: 0.44,
    pillX: 0.3117, // 122.5 / 393
    pillY: 0.5314, // 508 / 956
    arrowX: 0.3000,
    arrowY: 0.3900,
    locked: true,
  ),
  IslandModel(
    title: 'جزيرة الكلمات',
    titleKey: 'island_words',
    image: AppAssets.wordsIsland,
    x: 0.748, // 294 / 393
    y: 0.585, // 559 / 956
    size: 0.44,
    pillX: 0.7277, // 286 / 393
    pillY: 0.6276, // 600 / 956
    arrowX: 0.7400,
    arrowY: 0.4900,
    locked: true,
  ),
  IslandModel(
    title: 'جزيرة الجمل والقواعد',
    titleKey: 'island_sentences',
    image: AppAssets.grammarIsland,
    x: 0.316, // 124 / 393
    y: 0.710, // 679 / 956
    size: 0.46,
    pillX: 0.3219, // 126.5 / 393
    pillY: 0.7490, // 716 / 956
    arrowX: 0.3100,
    arrowY: 0.6100,
    locked: true,
  ),
  IslandModel(
    title: 'الكنز الكبير',
    titleKey: 'island_treasure',
    image: AppAssets.treasureIsland,
    x: 0.458, // 180 / 393
    y: 0.895, // 856 / 956
    size: 0.46,
    pillX: 0.4504, // 177 / 393
    pillY: 0.9404, // 899 / 956
    arrowX: 0.4500,
    arrowY: 0.7800,
    locked: false,
  ),
];
