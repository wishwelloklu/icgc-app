// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OfficiatingType extends Equatable {
  final UniqueKey id = UniqueKey();
  final String text;
  OfficiatingType({
    required this.text,
  });
  @override
  List<Object> get props => [text];

  static List<OfficiatingType> namingList = [
    OfficiatingType(text: 'Naming Ceremony at Home'),
    OfficiatingType(text: 'Naming Ceremony in the Church'),
    OfficiatingType(text: 'Naming and Dedication of Child in the Church'),
  ];

   static List<OfficiatingType> nList = [
    OfficiatingType(text: 'Naming Ceremony at Home'),
    OfficiatingType(text: 'Naming Ceremony in the Church'),
    OfficiatingType(text: 'Naming and Dedication of Child in the Church'),
  ];
}
