import 'package:get_storage/get_storage.dart';

class StorageService{
  isNewUser() => GetStorage().read("isFirstTime");
  updateIsNewUser(String value) => GetStorage().write("isFirstTime", value);


}