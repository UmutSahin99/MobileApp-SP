import 'package:flutter/material.dart';
import 'package:mobile_app/models/data_model.dart';

class PurchaseCardComponent extends StatelessWidget {
  final Data item;
  final VoidCallback onRemove;

  const PurchaseCardComponent({
    super.key,
    required this.item,
    required this.onRemove,
    required BuildContext context,
  });

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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              width: 100,
              height: 100,
              item.image ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 50);
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.name ?? 'No Title', style: TextStyle(fontSize: 14)),
                Text(item.tagline ?? ""),
                Text(
                  item.price != null ? '${item.price}' : 'No Price',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(onPressed: onRemove, icon: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
