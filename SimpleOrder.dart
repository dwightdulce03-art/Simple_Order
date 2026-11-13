const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('Item "$name" is not on the menu.');
  }
  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) {
  return items.fold(0.0, (sum, item) => sum + item.subtotal);
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  print('Order for ${customer ?? 'Guest'}');

  for (var item in items) {
    print('${item.qty} x ${item.name}'.padRight(18) + item.subtotal.toStringAsFixed(2).padLeft(10));
  }

  final sub = total(items);
  print('Subtotal'.padRight(18) + sub.toStringAsFixed(2).padLeft(10));

  if (sub >= 300) {
    final discount = sub * 0.10;
    print('Discount 10%'.padRight(18) + (-discount).toStringAsFixed(2).padLeft(10));
    print('Total'.padRight(18) + (sub - discount).toStringAsFixed(2).padLeft(10));
  } else {
    print('Total'.padRight(18) + sub.toStringAsFixed(2).padLeft(10));
  }
}

void main() {
  // First order: 3 Adobo rice, 1 Iced tea, 3 Turon (Guest)
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(order1);

  print(''); // Blank line separator

  // Second order: 1 Adobo rice, 1 Iced tea (Maria)
  final order2 = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 1),
  ];
  printReceipt(order2, customer: 'Maria');
}