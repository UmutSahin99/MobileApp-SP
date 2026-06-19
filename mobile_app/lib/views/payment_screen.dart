import 'package:flutter/material.dart';
import 'package:mobile_app/components/mini_card.dart';
import 'package:mobile_app/components/purchase_card.dart';
import 'package:mobile_app/models/data_model.dart';

class PaymentScreen extends StatefulWidget {
  final Set<int> cardIds;
  final List<Data> product;

  const PaymentScreen({
    super.key,
    required this.cardIds,
    required this.product,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedProducts = widget.product
        .where((product) => widget.cardIds.contains(product.id))
        .toList(); //toList bir fonksiyon olduğu için parantez aç kapa yapmamız gerekiyor.

    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: selectedProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          Text("Your list is empty. "),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: selectedProducts.length,
                        itemBuilder: (context, index) {
                          final item = selectedProducts[index];
                          return PurchaseCardComponent(
                            context: context,
                            item: item,
                            onRemove: () {
                              setState(() {
                                widget.cardIds.remove(item.id);
                              });
                            },
                          );
                        },
                      ),
                    ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.cardIds.clear();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Successfully Bought!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 50),
                backgroundColor: Colors.blue[600],
              ),
              child: Text(
                "Buy",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
