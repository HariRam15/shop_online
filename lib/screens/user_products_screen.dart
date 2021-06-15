import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/products.dart';
import 'package:shop_online/screens/edit_product_screen.dart';
import 'package:shop_online/widgets/app_drawer.dart';
import 'package:shop_online/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProcuts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditproductScreen.routename);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProcuts(context),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  productsData.items[index].id,
                  productsData.items[index].title,
                  productsData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
