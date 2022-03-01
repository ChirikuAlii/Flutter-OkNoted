import 'package:hive_flutter/hive_flutter.dart';
import 'package:okoted/data/local/box/note_model.dart';
import 'package:okoted/data/local/ok_noted_db.dart';
import 'package:okoted/main.dart';

class NoteDao {
  static final noteBox = Hive.box<NoteModel>(OkNotedDB.todoBox);

  static List<NoteModel> getNote() {
    return noteBox.values.toList().cast<NoteModel>();
  }

  static addNote(NoteModel item) async {
    await noteBox.add(item);
  }
}
