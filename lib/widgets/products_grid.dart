import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/products.dart';
import 'package:shop_online/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavts;
  ProductsGrid(this.showFavts);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavts ? productsData.favouriteItmes : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //amount of columns
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10, //spacing btw the columns
        mainAxisSpacing: 10, // spacing btw the rows
      ),
      //its a function that receives context and index of the item
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        //create: (ctx) => products[index],
        value: products[index],
        child: ProductItem(
            // products[index].id,
            //  products[index].imageUrl,
            //   products[index].title,
            ),
      ),
    );
  }
}
