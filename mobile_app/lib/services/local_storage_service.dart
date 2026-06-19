import 'package:shared_preferences/shared_preferences.dart';

// LocalStorageService, uygulamanın yerel depolama ihtiyaçlarını karşılamak için kullanılan bir hizmettir.
// Bu sınıf, SharedPreferences paketini kullanarak verileri kaydetme, alma ve silme işlemlerini sağlar.
// saveData yöntemi, belirli bir anahtar ve değeri kaydederken, getData yöntemi belirli bir anahtara karşılık gelen değeri alır.
// removeData yöntemi ise belirli bir anahtarı ve ona karşılık gelen değeri siler.
// Bu hizmet, uygulamanın kullanıcı tercihlerini veya diğer küçük verileri saklamak için kullanılabilir.

class LocalStorageService {
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

    print("Data saved: $key = $value");
  } // key value'yu işaret eden değer.

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print("Data removed: $key");
  }
}
