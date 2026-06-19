import 'package:flutter/material.dart';
import 'package:mobile_app/models/data_model.dart';
import 'package:mobile_app/services/api.dart';
import 'package:mobile_app/services/local_storage_service.dart';
import 'package:mobile_app/components/mini_card.dart';
import 'package:mobile_app/views/Mini_card_detail_screen.dart';
import 'package:mobile_app/views/payment_screen.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  LocalStorageService localStorageService = LocalStorageService();
  String storedUsername = '';

  Future<void> loadStoredUsername() async {
    final username = await localStorageService.getData('username');
    setState(() {
      storedUsername = username ?? '';
    });
  }

  List<Data> productList = [];
  bool isLoading = true;
  String errorMessage = '';
  ApiService apiService = ApiService();
  Set<int> cardIds = {};
  List<Data> filteredProductList = [];

  //Product data çekilmeden önce ekrana yükleme kısmında olduğumuzu göstermek için bir kısım yazıyoruz.
  //Sonra dataList isimlik değişkenimize ApiService içerisinde yazdığımız fetchData fonksiyonuyla JSON veriyi ProductDataModel formatına çeviriyoruz.
  //Yeni formatındaki veriyi productList isimli listeye atıyoruz ve ekrana gösteriyoruz.
  //Hata oluşursa da catch ile yakalayıp hata mesajı atıyoruz.

  Future<void> loadProductData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      final dataList = await apiService.fetchData();
      setState(() {
        productList = dataList.data ?? [];
        filteredProductList = List.from(productList);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load product data: $e';
        isLoading = false;
      });
    }
  }

  void searchProducts(String name) {
    setState(() {
      filteredProductList = productList.where((product) {
        return (product.name ?? '').toLowerCase().contains(name.toLowerCase());
      }).toList();
    });
  }

  //Builderdan önce çalışıyor ve ekrana buildden önce bir bilgi getirilmesi gerekiyorsa burada getiriliyor.
  @override
  void initState() {
    super.initState();
    loadStoredUsername();
    loadProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Information Screen")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome, ${storedUsername}!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          cardIds: cardIds,
                          product: productList,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
              ],
            ),
            SizedBox(height: 16),

            TextField(
              onChanged: searchProducts,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                itemCount: filteredProductList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProductList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MinicardDetailScreen(
                            product: product,
                            cardIds: cardIds,
                            allProducts: productList,
                          ),
                        ),
                      );
                    },
                    child: MiniCardComponent(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
