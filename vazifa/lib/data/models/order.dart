import 'package:vazifa/data/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.products,
    required this.orderDate,
  });
}
