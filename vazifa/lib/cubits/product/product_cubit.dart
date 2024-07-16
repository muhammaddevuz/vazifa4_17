import 'package:bloc/bloc.dart';
import 'package:vazifa/data/models/product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void loadProducts() {
    final products = <Product>[
      Product(
        id: '1',
        title: 'krasovka',
        image: 'https://www.jizzaxstat.uz/images/1211.png',
        price: '270.6',
      ),
      Product(
        id: '2',
        title: 'kurtka',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic687.png',
        price: '370.6',
      ),
      Product(
        id: '3',
        title: 'plash',
        image:
            'https://images2.zoodmall.uz/cdn-cgi/image/w=500,fit=contain,f=auto/https%3A%2F%2Fimg.joomcdn.net%2F2a0c3ad91fe34bdfb6115d9aa2f4cc5b2d4c7690_original.jpeg',
        price: '400.5',
      ),
      Product(
        id: '4',
        title: 'Kastyum shim',
        image:
            'https://static.ayol.uz/crop/8/4/730_485_80_84da652d902cee3d3bc1c6cdfd6c303c.jpg',
        price: '600.6',
      ),
      Product(
        id: '5',
        title: 'kurtka red',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic677.png',
        price: '380.6',
      ),
      Product(
        id: '6',
        title: 'koylak',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic676.png',
        price: '320.6',
      ),
      Product(
        id: '7',
        title: 'tungi kiyim',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic675.png',
        price: '120.6',
      ),
      Product(
        id: '8',
        title: 'qizil kurtka',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic670.png',
        price: '220.6',
      ),
      Product(
        id: '10',
        title: 'ayollar kastyumi',
        image: 'https://devel.prom.uz/upload/category_logos/202309/pic673.png',
        price: '280.6',
      ),
    ];
    emit(ProductLoaded(
        products, products.where((p) => p.isFavorite).toList(), products));
  }

  void addProduct(Product product) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = List<Product>.from(loadedState.products)
        ..add(product);
      emit(ProductLoaded(
          updatedProducts, loadedState.favorites, loadedState.cart));
    }
  }

  void updateProduct(Product product) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = loadedState.products.map((existingProduct) {
        return existingProduct.id == product.id ? product : existingProduct;
      }).toList();
      final updatedFavorites =
          updatedProducts.where((product) => product.isFavorite).toList();
      emit(ProductLoaded(updatedProducts, updatedFavorites, loadedState.cart));
    }
  }

  void toggleFavorite(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts = loadedState.products.map((product) {
        return product.id == id
            ? product.copyWith(isFavorite: !product.isFavorite)
            : product;
      }).toList();
      final updatedFavorites =
          updatedProducts.where((product) => product.isFavorite).toList();
      emit(ProductLoaded(updatedProducts, updatedFavorites, loadedState.cart));
    }
  }

  void addToCart(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final List<Product> updatedProducts = loadedState.products.map((product) {
        if (product.id == id && !product.isCart) {
          return product.copyWith(isCart: true);
        } else {
          return product;
        }
      }).toList();
      final updatedCart =
          updatedProducts.where((product) => product.isCart).toList();
      final updatedFavorites =
          loadedState.favorites.where((product) => product.isFavorite).toList();

      emit(ProductLoaded(updatedProducts, updatedFavorites, updatedCart));
    }
  }

  void removeFromCart(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final List<Product> updatedProducts = loadedState.products.map((product) {
        if (product.id == id && product.isCart) {
          // Agar mahsulot savatchada bo'lsa
          return product.copyWith(isCart: false);
        } else {
          return product;
        }
      }).toList();

      final updatedCart =
          updatedProducts.where((product) => product.isCart).toList();
      final updatedFavorites =
          loadedState.favorites.where((product) => product.isFavorite).toList();

      emit(ProductLoaded(updatedProducts, updatedFavorites, updatedCart));
    }
  }

  void deleteProduct(String id) {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final updatedProducts =
          loadedState.products.where((product) => product.id != id).toList();
      emit(ProductLoaded(
          updatedProducts,
          updatedProducts.where((p) => p.isFavorite).toList(),
          loadedState.cart));
    }
  }
}
