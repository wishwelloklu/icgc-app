import 'package:hive_flutter/hive_flutter.dart';

part 'naming_ceremoney_variable.g.dart';

@HiveType(typeId: 1)
class NamingCeremoneyVariable {
     @HiveField(0)
  final String child;
     @HiveField(1)
  final String father;
     @HiveField(2)
  final String? parent;
  NamingCeremoneyVariable( {this.parent, required this.child, required this.father});
}
