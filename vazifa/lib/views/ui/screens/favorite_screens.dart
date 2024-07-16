import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/cubits/product/product_cubit.dart';
import 'dart:math';

import 'package:vazifa/cubits/product/product_state.dart';

class FavoriteListScreen extends StatefulWidget {
  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sevimlilar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
                return ListTile(
                  title: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  leading: product.image != null || product.image!.isNotEmpty
                      ? SizedBox(
                          width: 60,
                          height: 45,
                          child: Image.network(
                            product.image!,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: _getRandomColor(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        )
                      : Container(
                          width: 65,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _getRandomColor(),
                          ),
                        ),
                  trailing: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: product.isFavorite
                        ? Icon(Icons.favorite, color: Colors.red, size: 20)
                        : Icon(
                            Icons.favorite_border,
                          ),
                    onPressed: () {
                      context.read<ProductCubit>().toggleFavorite(product.id);
                    },
                  ),
                  onLongPress: () {
                    context.read<ProductCubit>().deleteProduct(product.id);
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
        decoration: BoxDecoration(
            color: Colors.green),
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
                  // Navigator.pushReplacementNamed(context, '/favoriteScreen');
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
    );
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
