import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/coffee.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool notifications = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🔥 Reusable glass card
  Widget glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }

  void _showOrderHistory() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        if (orderHistory.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'No orders yet',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: orderHistory.length,
          itemBuilder: (context, index) {
            final order = orderHistory[index];

            return ListTile(
              leading: const Icon(Icons.local_cafe),
              title: Text(
                'Order #${index + 1}  •  \$${order.total.toStringAsFixed(2)}',
              ),
              subtitle: Text(
                order.items
                    .map((e) => '${e.coffee.name} x ${e.quantity}')
                    .join(', '),
              ),
              trailing: Text(
                '${order.date.hour.toString().padLeft(2, '0')}:${order.date.minute.toString().padLeft(2, '0')}',
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌈 Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.background,
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(20),
            child: FadeTransition(
              opacity: _controller,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(_controller),
                child: ListView(
                  children: [
                    const SizedBox(height: 80),

                    // 👤 USER INFO
                    glassCard(
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 36,
                            child: Text('☕', style: TextStyle(fontSize: 30)),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Coffee Lover',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'brewday@coffee.com',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ⚙️ PREFERENCES
                    glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preferences',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 🌙 REAL DARK MODE
                          SwitchListTile(
                            title: const Text('Dark Mode'),
                            value: themeNotifier.value == ThemeMode.dark,
                            onChanged: (v) {
                              themeNotifier.value =
                                  v ? ThemeMode.dark : ThemeMode.light;
                              setState(() {});
                            },
                          ),

                          SwitchListTile(
                            title: const Text('Order Notifications'),
                            value: notifications,
                            onChanged: (v) {
                              setState(() => notifications = v);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📊 STATS (REAL)
                    Row(
                      children: [
                        Expanded(
                          child: glassCard(
                            child: Column(
                              children: [
                                Text(
                                  '${orderHistory.length}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text('Orders'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: glassCard(
                            child: const Column(
                              children: [
                                Text(
                                  '4.8 ⭐',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Rating'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: glassCard(
                            child: const Column(
                              children: [
                                Text(
                                  'Latte',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Favorite'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 📜 ACTIONS
                    glassCard(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.receipt_long),
                            title: const Text('Order History'),
                            onTap: _showOrderHistory,
                          ),
                          const Divider(),
                          const ListTile(
                            leading: Icon(Icons.favorite_border),
                            title: Text('Favorites'),
                          ),
                          const Divider(),
                          const ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
