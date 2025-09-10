
import 'package:ai_hair/db_hair/hair_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBHair extends GetxService {
  late Database dbBase;

  Future<DBHair> init() async {
    await createHairDB();
    return this;
  }

  createHairDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'hair.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createHairTable(db);
        });
  }

  createHairTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS hair (id INTEGER PRIMARY KEY, createdTime TEXT, image BLOB)');
  }

  insertHair(HairEntity entity) async {
    final id = await dbBase.insert('hair', {
      'createdTime': entity.createdTime.toIso8601String(),
      'image': entity.image,
    });
    return id;
  }

  cleanHairsData(List<HairEntity> list) async {
    for (var item in list) {
      await dbBase.delete('hair', where: 'id = ?', whereArgs: [item.id]);
    }
  }

  cleanAllData() async {
    await dbBase.delete('hair');
  }

  Future<List<HairEntity>> getHairAllData() async {
    var result = await dbBase.query('hair', orderBy: 'createdTime DESC');
    return result.map((e) => HairEntity.fromJson(e)).toList();
  }
}
