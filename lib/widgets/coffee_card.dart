import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final VoidCallback onTap;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // ✅ GLASS COLOR CHANGES WITH THEME
              color: Theme.of(context)
                  .colorScheme
                  .surface
                  .withOpacity(0.35),

              borderRadius: BorderRadius.circular(24),

              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: coffee.name,
                  child: Text(
                    coffee.emoji,
                    style: const TextStyle(fontSize: 46),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  coffee.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${coffee.price}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
