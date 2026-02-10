import 'package:flutter/material.dart';
import '../models/coffee.dart';
import 'cart_page.dart';

class DetailsPage extends StatefulWidget {
  final Coffee coffee;
  const DetailsPage({super.key, required this.coffee});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final total = widget.coffee.price * qty;

    return Scaffold(
      appBar: AppBar(title: Text(widget.coffee.name)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: widget.coffee.name,
            child: Text(
              widget.coffee.emoji,
              style: const TextStyle(fontSize: 120),
            ),
          ),

          const SizedBox(height: 20),
          Text('Quantity: $qty'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        if (qty > 1) qty--;
                      }),
                  icon: const Icon(Icons.remove)),
              IconButton(
                  onPressed: () => setState(() => qty++),
                  icon: const Icon(Icons.add)),
            ],
          ),
          Text('Total: \$${total.toStringAsFixed(2)}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final existingItem = cartItems.where(
                (item) => item.coffee.name == widget.coffee.name,
              );

              if (existingItem.isNotEmpty) {
                existingItem.first.quantity += qty;
              } else {
                cartItems.add(CartItem(widget.coffee, qty));
              }

              Navigator.pop(context); // go back to Home
            },
            child: const Text('Add to Cart'),
          ),

        ],
      ),
    );
  }
}
