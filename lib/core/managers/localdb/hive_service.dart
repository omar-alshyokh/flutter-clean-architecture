
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../utils/app_utils.dart';

class HiveAdapterTypeIds {
  static const int reportAdapterId = 0;
  static const int singleLogAdapterId = 1;
  static const int organizationAdapterId = 2;
}

@Injectable()
class HiveService {
  registerAdapters() async {
    try {
      /// Register Hive Adapter here
      // Hive.registerAdapter(YourAdapter());

    } catch (e) {
      appPrint('An error occurred in register hive adapters:$e');
      return;
    }
  }

  dropDb() async {
    try {
      /// delete your boxes here
      // await findDep<YourBoxHandler>().delete();
    } catch (e) {}
  }

  Future<bool> isExists({required String boxName}) async {
    try {
      final exist = await Hive.boxExists(boxName);
      return exist;
    } catch (e, stacktrace) {
      appPrint('An error happened in: isExists() $boxName  exception  ,$e');
      return false;
    }
  }

  addBoxes<T>(List<T> items, String boxName) async {
    appPrint('adding $boxName  boxes${items.length}');

    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
  }

  getBoxes<T>(String boxName) async {
    try {
      final openBox = await Hive.openBox(boxName);
      int length = openBox.length;
      appPrint('get cache$length');
      return openBox.toMap();
    } catch (e, stacktrace) {
      appPrint('An error happened in: getBoxes $boxName  exception  ,$e');
      return null;
    }
  }

  deleteBoxes<T>(String boxName) async {
    final openBox = await Hive.openBox(boxName);

    await openBox.clear();

    return null;
  }

  Future<void> updateItem(String boxName, dynamic key, dynamic value) async {
    final openBox = await Hive.openBox(boxName);
    await openBox.put(key, value);
  }

  addItemsToBox<T>(String boxName, Map<T, T> items) async {
    List<T> boxList = <T>[];

    final openBox = await Hive.openBox(boxName);
    items.forEach((key, value) {
      String keyStr = key.toString().replaceAll('’', '');
      openBox.put(keyStr, value);
    });
    return boxList;
  }
}
