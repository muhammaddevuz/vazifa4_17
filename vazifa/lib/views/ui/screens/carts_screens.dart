import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/cubits/product/product_cubit.dart';
import 'package:vazifa/cubits/product/product_state.dart';
import 'package:vazifa/views/ui/widgets/order_list_item.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({Key? key}) : super(key: key);

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Savat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            if (state.cart.isEmpty) {
              return Center(
                child: Text(
                  'Savat bo\'sh',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final product = state.cart[index];
                final Color randomColor = _getRandomColor();
                return ListTile(
                  title: Text(product.title ?? ''),
                  leading: product.image != null && product.image!.isNotEmpty
                      ? Container(
                          width: 60,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.network(
                            product.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: randomColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 45,
                          decoration: BoxDecoration(
                            color: randomColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${product.price}' ?? 'narxi kiritilmagan',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          context
                              .read<ProductCubit>()
                              .removeFromCart(product.id);
                        },
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          height: 280,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      product.image != null &&
                                              product.image!.isNotEmpty
                                          ? SizedBox(
                                              width: 160,
                                              height: 100,
                                              child: Image.network(
                                                product.image!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 160,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: randomColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Icon(Icons.error),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              width: 160,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: randomColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '\$${product.price}' ??
                                            'narxi kiritilmagan',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 100),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ZoomTapAnimation(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () {
                                      String price = product.price ?? '';
                                      String productName = product.title ?? '';
                                      String imageUrl = product.image ?? '';
                                      String otherInfo = '';
                                      String productId = product.id ?? '';

                                      OrderImages orderImages = OrderImages(
                                        productName: productName,
                                        imageUrl: imageUrl,
                                        otherInfo: otherInfo,
                                        productPrice: price,
                                        productId: productId,
                                      );

                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => orderImages,
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/productScreen');
              },
              icon: Icon(
                Icons.home,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                // Navigator.pushReplacementNamed(context, '/cartScreen');
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/favoriteScreen');
              },
              icon: Icon(
                Icons.favorite_outline,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/settingsScreen');
              },
              icon: Icon(
                Icons.settings,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Color _getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
