import 'profile_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'success_page.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int index = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomePage(),

      CartPage(
        onAddMore: () {
          setState(() {
            index = 0; // 👈 switch back to Home tab
          });
        },
        onOrderPlaced: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SuccessPage(
                onGoHome: () {
                  Navigator.pop(context); // close success screen
                  setState(() {
                    index = 0; // back to Home tab
                  });
                },
              ),
            ),
          );
        },
      ),

      const ProfilePage(),
 // Profile / Future page
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() {
            index = i;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
