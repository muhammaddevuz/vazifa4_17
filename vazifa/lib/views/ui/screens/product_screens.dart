import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/cubits/product/product_cubit.dart';
import 'dart:math';

import 'package:vazifa/cubits/product/product_state.dart';
import 'package:vazifa/views/ui/widgets/product_add_dialog_widget.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mahsulotlar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 260,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 2 / 3,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final Color randomColor = _getRandomColor();
                return Card(
                  child: Column(
                    children: [
                      product.image != null && product.image!.isNotEmpty
                          ? SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: Image.network(
                                product.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 100,
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
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: randomColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.title ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: product.isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 22,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: 22,
                                        ),
                                  onTap: () {
                                    context
                                        .read<ProductCubit>()
                                        .toggleFavorite(product.id);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${product.price}" ?? 'narxi kiritilmagan',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductCubit>()
                                        .addToCart(product.id);
                                  },
                                  child: Icon(
                                    CupertinoIcons.cart,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddProductDialog(
                                            product: product);
                                      },
                                    );
                                  },
                                  child: Icon(Icons.edit,
                                      size: 20, color: Colors.blue),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductCubit>()
                                        .deleteProduct(product.id);
                                  },
                                  child: Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                )),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/cartScreen');
                },
                icon: Icon(
                  CupertinoIcons.cart,
                  size: 25,
                  color: Colors.white,
                )),
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
                )),
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
                )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddProductDialog();
            },
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
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
