import 'package:bloc/bloc.dart';
import 'package:vazifa/data/models/order.dart';
import 'package:vazifa/data/models/product.dart';

class OrderCubit extends Cubit<List<Order>> {
  OrderCubit() : super([]);

  void addOrder(List<Product> products) {
    final newOrder = Order(
      id: DateTime.now().toString(),
      products: products,
      orderDate: DateTime.now(),
    );
    state.add(newOrder);
    emit(List.from(state));
  }

  void removeOrder(String productName) {
    state.removeWhere((order) => order.products.any((product) => product.title == productName));
    emit(List.from(state));
  }
}
