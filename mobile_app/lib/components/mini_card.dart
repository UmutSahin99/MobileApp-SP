import 'package:flutter/material.dart';
import 'package:mobile_app/models/data_model.dart';
import 'package:mobile_app/views/login_screen.dart';

class MiniCardComponent extends StatelessWidget {
  final Data item;

  const MiniCardComponent(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 8, 7, 7).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                item.image ?? '',
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 50);
                },
              ),
            ),
          ),
          Text(
            item.name ?? 'No Title',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            item.price != null ? '${item.price}' : 'No Price',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
