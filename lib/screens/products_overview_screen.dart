import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/cart.dart';
import 'package:shop_online/screens/cart_screen.dart';
import 'package:shop_online/widgets/app_drawer.dart';
import 'package:shop_online/widgets/badge.dart';
import 'package:shop_online/widgets/products_grid.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Online'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              //here im giving the child of builder to badge child
              child: ch,
              // cart length that is comming from builder is connecting
              //to value in badge
              value: cart.itemCount.toString(),
            ),
            //also im giving a iconButton as a child to consumer that automatically
            // connects to the ch which is the actual child

            //this child is written outside to avoid the rebuild on
            //IconButton every time its load/rebuild
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
