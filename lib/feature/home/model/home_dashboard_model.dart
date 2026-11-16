class HomeDashboardModel {
  final String childName;
  final String currentIsland;
  final int totalStars;
  final int totalCoins;
  final double progressPercentage;
  final String? parentName;
  final String? tipTitle;
  final String? tipContent;

  HomeDashboardModel({
    required this.childName,
    required this.currentIsland,
    required this.totalStars,
    required this.totalCoins,
    required this.progressPercentage,
    this.parentName,
    this.tipTitle,
    this.tipContent,
  });

  factory HomeDashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;

    String name = 'عمر';
    String currentIsland = 'جزيرة الحروف';
    int stars = 0;
    int coins = 100;
    double progress = 0.0;
    String? parent;
    String? tipTitle;
    String? tipContent;

    // استخراج اسم ولي الأمر
    if (data['parent'] is Map) {
      parent = data['parent']['name'] as String?;
    } else if (data['parent_name'] is String) {
      parent = data['parent_name'] as String?;
    }

    // استخراج بيانات الطفل النشط
    if (data['active_child'] is Map) {
      final child = data['active_child'] as Map<String, dynamic>;
      name = child['name'] as String? ?? name;
      currentIsland = child['current_island'] as String? ?? currentIsland;
      stars = _parseInt(child['total_stars']) ?? stars;
      coins = _parseInt(child['total_coins']) ?? coins;
      progress = _parseDouble(child['progress_percentage']) ?? progress;
    } else if (data['children'] is List && (data['children'] as List).isNotEmpty) {
      final firstChild = (data['children'] as List).first;
      if (firstChild is Map<String, dynamic>) {
        name = firstChild['name'] as String? ?? firstChild['child_name'] as String? ?? name;
        currentIsland = firstChild['current_island'] as String? ?? currentIsland;
        progress = _parseDouble(firstChild['progress_percentage']) ?? progress;
      }
    }

    // استخراج نصيحة اليوم إن وجدت
    if (data['tip_of_day'] is Map) {
      tipTitle = data['tip_of_day']['title'] as String?;
      tipContent = data['tip_of_day']['content'] as String?;
    }

    return HomeDashboardModel(
      childName: name,
      currentIsland: currentIsland,
      totalStars: stars,
      totalCoins: coins,
      progressPercentage: progress,
      parentName: parent,
      tipTitle: tipTitle,
      tipContent: tipContent,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
