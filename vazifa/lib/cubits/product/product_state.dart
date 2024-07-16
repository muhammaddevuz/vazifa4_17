import 'package:equatable/equatable.dart';
import 'package:vazifa/data/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> favorites;
  final List<Product> cart;

  const ProductLoaded(this.products, this.favorites, this.cart);

  @override
  List<Object> get props => [products, favorites, cart];
}
