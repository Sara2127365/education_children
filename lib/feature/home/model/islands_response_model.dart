class IslandsResponseModel {
  final int totalIslands;
  final int completedIslands;
  final int totalStars;
  final int totalCoins;
  final List<IslandItemModel> islands;

  IslandsResponseModel({
    required this.totalIslands,
    required this.completedIslands,
    required this.totalStars,
    required this.totalCoins,
    required this.islands,
  });

  factory IslandsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;

    final islandsList = <IslandItemModel>[];
    if (data['islands'] is List) {
      for (final item in data['islands']) {
        if (item is Map<String, dynamic>) {
          islandsList.add(IslandItemModel.fromJson(item));
        }
      }
    }

    return IslandsResponseModel(
      totalIslands: _parseInt(data['total_islands']) ?? islandsList.length,
      completedIslands: _parseInt(data['completed_islands']) ?? 0,
      totalStars: _parseInt(data['total_stars']) ?? 0,
      totalCoins: _parseInt(data['total_coins']) ?? 0,
      islands: islandsList,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class IslandItemModel {
  final String id;
  final String title;
  final double progressPercentage;
  final bool isUnlocked;

  IslandItemModel({
    required this.id,
    required this.title,
    required this.progressPercentage,
    required this.isUnlocked,
  });

  factory IslandItemModel.fromJson(Map<String, dynamic> json) {
    return IslandItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      progressPercentage: (json['progress_percentage'] is num)
          ? (json['progress_percentage'] as num).toDouble()
          : (double.tryParse(json['progress_percentage']?.toString() ?? '') ?? 0.0),
      isUnlocked: json['is_unlocked'] == true ||
          json['status_type'] == 'completed' ||
          json['status_type'] == 'in_progress',
    );
  }
}
