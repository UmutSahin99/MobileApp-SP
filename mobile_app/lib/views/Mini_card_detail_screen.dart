import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/data_model.dart';
import 'package:mobile_app/views/payment_screen.dart';

class MinicardDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int> cardIds;
  final List<Data> allProducts;

  const MinicardDetailScreen({
    super.key,
    required this.product,
    required this.cardIds,
    required this.allProducts,
  });

  @override
  State<MinicardDetailScreen> createState() => _MinicardDetailScreenState();
}

class _MinicardDetailScreenState extends State<MinicardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.product.image ?? '',
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.product.name ?? 'No Title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.product.description != null
                    ? '${widget.product.description}'
                    : 'No Description',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 30),

              Text(
                "${widget.product.price}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Colors.blue[600],
                    ),
                    onPressed: () {
                      setState(() {
                        widget.cardIds.add(widget.product.id ?? 0);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added to card"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Text(
                      "Purchase",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Colors.blue[600],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            cardIds: widget.cardIds,
                            product: widget.allProducts,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Finish",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // şuan bir state olduğumuz için widgetın elemanlarına doğrudan erişemiyoruz bu sebeple widget.product.name şeklinde erişiyoruz. Eğer stateless widget olsaydık direk product.name şeklinde erişebilirdik.
    );
  }
}
