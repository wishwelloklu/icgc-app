// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:icgc/app/theme/app_images.dart';

class EventsModel extends Equatable {
  final String title;
  final String description;
  final String image;
  const EventsModel({
    required this.title,
    required this.description,
    required this.image,
  });

  EventsModel copyWith({
    String? title,
    String? description,
    String? image,
  }) {
    return EventsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsModel.fromJson(String source) =>
      EventsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, description, image];

  static List<EventsModel> eventMock = const [
    EventsModel(
      title: 'Greater Works 2024',
      description:
          "\"Greater works\" is a phrase that refers to the work of Jesus' followers that extend beyond his earthly ministry. It can also refer to the idea that believers can do greater works than Jesus himself.",
      image: AppImages.foutyOne,
    ),
 
   
    EventsModel(
      title: 'Doulos',
      description:
          "\"Greater works\" is a phrase that refers to the work of Jesus' followers that extend beyond his earthly ministry. It can also refer to the idea that believers can do greater works than Jesus himself.",
      image: AppImages.doulos,
    ),
    EventsModel(
      title: '40 Days Of Power',
      description:
          "The significance of 40 days in the Bible is that God allows us to go through challenges in order to grow spiritually. The 40-day time period highlights the importance of strengthening our faith by relying on God's help in challenging circumstances. Also, 40 days highlights God's patience with us.",
      image: AppImages.foutyDays,
    ),
    EventsModel(
      title: 'Greater Works 2024',
      description:
          "\"Greater works\" is a phrase that refers to the work of Jesus' followers that extend beyond his earthly ministry. It can also refer to the idea that believers can do greater works than Jesus himself.",
      image: AppImages.greaterWorks,
    ),
  ];
}
