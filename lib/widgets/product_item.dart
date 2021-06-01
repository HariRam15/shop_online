import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/cart.dart';
import 'package:shop_online/providers/product.dart';
import 'package:shop_online/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //here im making only favourite iconbutton widget a listner
          leading: Consumer<Product>(
            //below explained in U203
            builder: (ctx, product, _) {
              var iconButton = IconButton(
                onPressed: () {
                  product.toffleFavoritesStatus();
                },
                color: Theme.of(context).accentColor,
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
              );
              return iconButton;
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //we are fordwing the product details to cart
              cart.addItem(product.id, product.price, product.title);
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
