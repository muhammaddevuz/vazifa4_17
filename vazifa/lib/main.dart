import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/cubits/order/order_cubit.dart';
import 'package:vazifa/cubits/product/product_cubit.dart';
import 'package:vazifa/cubits/theme/theme_cubit.dart';
import 'package:vazifa/views/ui/screens/carts_screens.dart';
import 'package:vazifa/views/ui/screens/favorite_screens.dart';
import 'package:vazifa/views/ui/screens/product_screens.dart';
import 'package:vazifa/views/ui/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..loadProducts()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => OrderCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: ProductListScreen(),
            initialRoute: '/',
            routes: {
              '/productScreen': (context) => ProductListScreen(),
              '/favoriteScreen': (context) => FavoriteListScreen(),
              '/settingsScreen': (context) => SettingsScreen(),
              '/cartScreen': (context) => CartScreens(),
            },
          );
        },
      ),
    );
  }
}
