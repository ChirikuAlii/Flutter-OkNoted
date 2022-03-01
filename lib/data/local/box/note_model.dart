import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final String project;

  NoteModel(
      {required this.title,
      required this.date,
      required this.desc,
      required this.project});
}
