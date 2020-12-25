import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart' show Cart;
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Consumer<Cart>(
                      builder: (_, cart, _1) => Chip(
                            label: Text(
                              '${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1
                                      .color),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          )),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<Cart>(
              builder: (_, cart, _1) => Expanded(
                    child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          var cartItem = cart.items.values.toList()[i];
                          print(cartItem);
                          return CartItem(
                              cartItem.id,
                              cart.items.keys.toList()[i],
                              cartItem.price,
                              cartItem.quantity,
                              cartItem.title);
                        },
                        itemCount: cart.itemsCount),
                  )),
        ],
      ),
    );
  }
}
