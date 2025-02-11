// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ThemeModel extends Equatable {
  final String theme;
  final String year;
  final String imageUrl;
  final String declaration;
  const ThemeModel({
    required this.theme,
    required this.year,
    required this.imageUrl,
    required this.declaration,
  });

  ThemeModel copyWith({
    String? theme,
    String? year,
    String? imageUrl,
    String? declaration,
  }) {
    return ThemeModel(
      theme: theme ?? this.theme,
      year: year ?? this.year,
      imageUrl: imageUrl ?? this.imageUrl,
      declaration: declaration ?? this.declaration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
      'year': year,
      'imageUrl': imageUrl,
      'declaration': declaration,
    };
  }

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      theme: map['theme'] as String,
      year: map['year'] as String,
      imageUrl: map['imageUrl'] as String,
      declaration: map['declaration'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromJson(String source) =>
      ThemeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [theme, imageUrl, declaration,year];

  static List<ThemeModel> themesMock = [
    const ThemeModel(
        theme: 'Jesus',
        year: '2025',
        imageUrl: 'assets/images/themes/2025.webp',
        declaration:
            'Blessed are you, O God\nKing of the Universe\nWho gives me life\nand breath\n\nToday I stand in your presence\nTo proclaim\nOne Lord\nand Saviour\nJesus Christ\n\nThe Living WORD\n\nWithout Beginning\nWithout End\n\nLight of Light\nTruly God, Truly Man\nHe is Immanuel\nGod with us\n\nIn Christ\nI am Known\n\nIn Him, I stand\nRedeemed\nAnd Justified\n\nOf His fulness,\nI receive\nGrace for grace\n\nI have decided\nTo follow Jesus\nAnd proclaim Him\n\nTo live\nIn His Righteousness\n\nTo walk\nIn His Word\n\nTo move\nIn His Spirit\nTo work\n\nThe works of God\n\nEach day\nEach hour\nEach moment\n\nIn Jesus’ name\nAmen!'),
    const ThemeModel(
      theme: 'God',
      year: '2024',
      imageUrl: 'assets/images/themes/2024.jpeg',
      declaration:
          'Blessed are you,\nO Lord King of the Universe Who gives me life and breath Today,\nI stand in your presence to declare your praise\nHoly, Holy, Holy Lord God Almighty Who was, is and is to come\nYour name I AM Is from generation,\nTo generation You are my God\nGood and merciful Awesome in wonders\nWith you Nothing is impossible\nFrom your word I receive guidance\nFrom your hand I receive abundance\nToday, I boldly declare, This is My God Year,\nShow me your glory,\nHeavenly Father, Let me know you\nOpen my eyes To see\nOpen my heart To understand\nOpen the heavens.Over my life In Jesus’ name\nAmen',
    ),
    const ThemeModel(
      theme: 'Increase',
      year: '2022',
      imageUrl: 'assets/images/themes/2022.jpg',
      declaration:
          'Blessed are you,\nO Lord King of the Universe Who gives me life and breath Today,\nI stand in your presence to declare your praise\nHoly, Holy, Holy Lord God Almighty Who was, is and is to come\nYour name I AM Is from generation,\nTo generation You are my God\nGood and merciful Awesome in wonders\nWith you Nothing is impossible\nFrom your word I receive guidance\nFrom your hand I receive abundance\nToday, I boldly declare, This is My God Year,\nShow me your glory,\nHeavenly Father, Let me know you\nOpen my eyes To see\nOpen my heart To understand\nOpen the heavens.Over my life In Jesus’ name\nAmen',
    ),
    const ThemeModel(
      theme: 'Excellence',
      year: '2020',
      imageUrl: 'assets/images/themes/2020.jpg',
      declaration:
          'Blessed are you,\nO Lord King of the Universe Who gives me life and breath Today,\nI stand in your presence to declare your praise\nHoly, Holy, Holy Lord God Almighty Who was, is and is to come\nYour name I AM Is from generation,\nTo generation You are my God\nGood and merciful Awesome in wonders\nWith you Nothing is impossible\nFrom your word I receive guidance\nFrom your hand I receive abundance\nToday, I boldly declare, This is My God Year,\nShow me your glory,\nHeavenly Father, Let me know you\nOpen my eyes To see\nOpen my heart To understand\nOpen the heavens.Over my life In Jesus’ name\nAmen',
    ),
    const ThemeModel(
      theme: 'Leadership',
      year: '2017',
      imageUrl: 'assets/images/themes/2017.jpg',
      declaration:
          'Blessed are you,\nO Lord King of the Universe Who gives me life and breath Today,\nI stand in your presence to declare your praise\nHoly, Holy, Holy Lord God Almighty Who was, is and is to come\nYour name I AM Is from generation,\nTo generation You are my God\nGood and merciful Awesome in wonders\nWith you Nothing is impossible\nFrom your word I receive guidance\nFrom your hand I receive abundance\nToday, I boldly declare, This is My God Year,\nShow me your glory,\nHeavenly Father, Let me know you\nOpen my eyes To see\nOpen my heart To understand\nOpen the heavens.Over my life In Jesus’ name\nAmen',
    ),
    const ThemeModel(
      theme: 'Perfection',
      year: '2015',
      imageUrl: 'assets/images/themes/2015.jpeg',
      declaration:
          'Blessed are you,\nO Lord King of the Universe Who gives me life and breath Today,\nI stand in your presence to declare your praise\nHoly, Holy, Holy Lord God Almighty Who was, is and is to come\nYour name I AM Is from generation,\nTo generation You are my God\nGood and merciful Awesome in wonders\nWith you Nothing is impossible\nFrom your word I receive guidance\nFrom your hand I receive abundance\nToday, I boldly declare, This is My God Year,\nShow me your glory,\nHeavenly Father, Let me know you\nOpen my eyes To see\nOpen my heart To understand\nOpen the heavens.Over my life In Jesus’ name\nAmen',
    ),
  ];
}
