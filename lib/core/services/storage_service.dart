import 'package:hive/hive.dart';

class StorageService {
  static const _storageBox = "storageBox";

  Future<T> save<T>(String key, T value) async {
    final Box box = await Hive.openBox(_storageBox);

    await box.put(key, value);

    return value;
  }

  Future<T> get<T>(String key) async {
    final Box box = await Hive.openBox(_storageBox);

    final data = await box.get(key);

    return data;
  }
}
