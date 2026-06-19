import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/data_model.dart';

class ApiService {
  Future<ProductDataModel> fetchData() async {
    final response = await http.get(
      Uri.parse('https://wantapi.com/products.php'),
    );

    //Status code 200 ise response.bodydeki bilgileri dart::convert kütüphanesindeki jsonDecode fonksiyonu ile decode ediyoruz.
    //Sonra bodydeki data listesinin içindeki bilgileri List formatında list isimli değişkene atıyoruz.
    //Ve son olarak list değişkenindeki her bir itemi ProductData modeline dönüştürüp List<ProductData> formatında döndürüyoruz.

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ProductDataModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
