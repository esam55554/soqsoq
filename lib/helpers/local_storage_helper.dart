import 'package:get_storage/get_storage.dart';

class LocalStorageHelper{
  static LocalStorageHelper? _instance;
  LocalStorageHelper._();
  GetStorage box=GetStorage();

  static LocalStorageHelper get getInstance{
    _instance??=LocalStorageHelper._();

    return _instance!;
  }
  readKey({required String key}){
    return box.read(key);
  }
  writeKey({required String key,required String value}){
    return box.write(key, value);
  }
  removeKey({required String key}){
    return box.remove(key);
  }
}