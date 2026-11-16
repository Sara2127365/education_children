class CharacterProgressModel {
  final int characterId;
  final String character;
  final String name;
  final bool isUnlocked;
  final bool isCompleted;
  final int starsCount;
  final int totalSteps;

  CharacterProgressModel({
    required this.characterId,
    required this.character,
    required this.name,
    required this.isUnlocked,
    required this.isCompleted,
    required this.starsCount,
    required this.totalSteps,
  });

  factory CharacterProgressModel.fromJson(Map<String, dynamic> json) {
    return CharacterProgressModel(
      characterId: _parseInt(json['character_id']) ?? 0,
      character: json['character'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isUnlocked: json['is_unlocked'] == true,
      isCompleted: json['is_completed'] == true,
      starsCount: _parseInt(json['stars_count']) ?? 0,
      totalSteps: _parseInt(json['total_steps']) ?? 1,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
