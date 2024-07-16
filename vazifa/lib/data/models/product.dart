import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String? image;
  final bool isFavorite;
  final String? price;
  final bool isCart;

  Product({
    required this.id,
    required this.title,
    this.image,
    this.isFavorite = false,
    this.isCart = false,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? title,
    String? image,
    bool? isFavorite,
    String? price,
    bool? isCart,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      isCart: isCart ?? this.isCart,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, title, image, isFavorite, price, isCart];
}
