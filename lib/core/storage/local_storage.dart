abstract class LocalStorage {
  Future<bool> setValue(String key, String value);
  Future<dynamic> getValue(String key);
  Future<bool> clearValue(String key);
}
