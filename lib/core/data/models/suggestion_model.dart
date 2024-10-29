import 'package:equatable/equatable.dart';

class SuggestionModel extends Equatable {
  final String id;
  final String suggestion;
  const SuggestionModel({required this.id, required this.suggestion});

  @override
  List<Object?> get props => [id, suggestion];

  static List<SuggestionModel> suggestionList = [
    const SuggestionModel(id: '1', suggestion: 'Healing Words'),
    const SuggestionModel(id: '2', suggestion: 'Sacred Scriptures'),
    const SuggestionModel(id: '3', suggestion: 'Enlightening Stories'),
    const SuggestionModel(id: '4', suggestion: 'Devotional'),
    const SuggestionModel(id: '5', suggestion: 'Wisdom in Words'),
    const SuggestionModel(id: '6', suggestion: 'Soul Nourishment'),
    const SuggestionModel(id: '7', suggestion: 'Meditative'),
    const SuggestionModel(id: '8', suggestion: 'Faith-Filled Tales'),
    const SuggestionModel(id: '9', suggestion: 'Inspirational Reads'),
    const SuggestionModel(id: '10', suggestion: 'Spiritual Journeys'),
  ];
}
