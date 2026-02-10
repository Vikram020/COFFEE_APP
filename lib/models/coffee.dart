class Coffee {
  final String name;
  final double price;
  final String emoji;

  Coffee(this.name, this.price, this.emoji);
}

class CartItem {
  final Coffee coffee;
  int quantity;

  CartItem(this.coffee, this.quantity);
}

class Order {
  final DateTime date;
  final List<CartItem> items;
  final double total;

  Order(this.date, this.items, this.total);
}

// Coffee menu
final coffeeList = [
  Coffee('Cappuccino', 4.5, '☕'),
  Coffee('Latte Macchiato', 3.8, '🥛'),
  Coffee('Mocha', 4.2, '🍫'),
  Coffee('Espresso', 2.5, '⚡'),
  Coffee('Marocchino', 4.8, '🧉'),
  Coffee('Americano', 3.5, '☕︎'),
  Coffee('Cortado', 4.0, '🧋'),
  Coffee('Frappe', 1.5, '🍵'),
  Coffee('Irish', 4.5, '🍹'),
];

// 🛒 Cart
List<CartItem> cartItems = [];

// 📦 Orders
List<Order> orderHistory = [];
