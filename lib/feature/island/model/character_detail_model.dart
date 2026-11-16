class CharacterDetailModel {
  final int characterId;
  final String character;
  final String name;
  final int totalSteps;
  final List<CharacterStepModel> steps;

  CharacterDetailModel({
    required this.characterId,
    required this.character,
    required this.name,
    required this.totalSteps,
    required this.steps,
  });

  factory CharacterDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;

    final stepsList = <CharacterStepModel>[];
    if (data['steps'] is List) {
      for (final step in data['steps']) {
        if (step is Map<String, dynamic>) {
          stepsList.add(CharacterStepModel.fromJson(step));
        }
      }
    }

    return CharacterDetailModel(
      characterId: _parseInt(data['character_id']) ?? 0,
      character: data['character'] as String? ?? '',
      name: data['name'] as String? ?? '',
      totalSteps: _parseInt(data['total_steps']) ?? stepsList.length,
      steps: stepsList,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class CharacterStepModel {
  final int stepNumber;
  final String type;
  final String title;
  final String? wordText;
  final String? wordBreakdown;
  final String? imageUrl;
  final String? audioUrl;
  final int points;
  final List<StepChoiceModel> choices;

  CharacterStepModel({
    required this.stepNumber,
    required this.type,
    required this.title,
    this.wordText,
    this.wordBreakdown,
    this.imageUrl,
    this.audioUrl,
    this.points = 10,
    this.choices = const [],
  });

  factory CharacterStepModel.fromJson(Map<String, dynamic> json) {
    String? word;
    String? breakdown;
    String? image;

    if (json['word'] is Map) {
      final w = json['word'] as Map<String, dynamic>;
      word = w['text'] as String?;
      breakdown = w['breakdown'] as String?;
      image = w['image_url'] as String?;
    } else {
      image = json['image_url'] as String?;
    }

    final choicesList = <StepChoiceModel>[];
    if (json['choices'] is List) {
      for (final c in json['choices']) {
        if (c is Map<String, dynamic>) {
          choicesList.add(StepChoiceModel.fromJson(c));
        }
      }
    }

    return CharacterStepModel(
      stepNumber: _parseInt(json['step_number']) ?? 1,
      type: json['type'] as String? ?? 'LESSON_EXPLANATION',
      title: json['title'] as String? ?? '',
      wordText: word,
      wordBreakdown: breakdown,
      imageUrl: image,
      audioUrl: json['audio_url'] as String?,
      points: _parseInt(json['points']) ?? 10,
      choices: choicesList,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class StepChoiceModel {
  final String id;
  final String text;
  final String? imageUrl;
  final bool isCorrect;

  StepChoiceModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.isCorrect,
  });

  factory StepChoiceModel.fromJson(Map<String, dynamic> json) {
    return StepChoiceModel(
      id: json['id']?.toString() ?? '',
      text: json['text'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      isCorrect: json['is_correct'] == true,
    );
  }
}
