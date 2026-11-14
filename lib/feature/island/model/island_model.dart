import 'package:education_children/core/style/app_assets.dart';

class IslandModel {
  final String title;
  final String image;
  final double x;            // island center as a fraction of width
  final double y;            // island center as a fraction of height
  final double size;        // island width as a fraction of screen width
  final double labelBottom; // title position from the island bottom (fraction of island width)
  final bool locked;

  const IslandModel({
    required this.title,
    required this.image,
    required this.x,
    required this.y,
    required this.size,
    this.labelBottom = 0.08,
    this.locked = true,
  });

  IslandModel copyWith({bool? locked}) => IslandModel(
        title: title,
        image: image,
        x: x,
        y: y,
        size: size,
        labelBottom: labelBottom,
        locked: locked ?? this.locked,
      );
}

const islands = <IslandModel>[
  IslandModel(
    title: 'جزيرة الحروف',
    image: AppAssets.lettersIsland,
    x: 0.33,
    y: 0.28,
    size: 0.40,
    locked: false,
  ),
  IslandModel(
    title: 'جزيرة الحركات',
    image: AppAssets.harakatIsland,
    x: 0.77,
    y: 0.38,
    size: 0.38,
  ),
  IslandModel(
    title: 'جزيرة حروف المد',
    image: AppAssets.maddIsland,
    x: 0.31,
    y: 0.47,
    size: 0.40,
  ),
  IslandModel(
    title: 'جزيرة الكلمات',
    image: AppAssets.wordsIsland,
    x: 0.75,
    y: 0.565,
    size: 0.40,
  ),
  IslandModel(
    title: 'جزيرة الجمل والقواعد',
    image: AppAssets.grammarIsland,
    x: 0.31,
    y: 0.69,
    size: 0.50,
  ),
 IslandModel(
  title: 'الكنز الكبير',
  image: AppAssets.treasureIsland,
  x: 0.46,
  y: 0.85,
  size: 0.42,
  labelBottom: 0.05,
  locked: false,
),
];