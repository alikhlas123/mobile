import 'package:flutter/material.dart';
import 'package:vendor_banjari/Cart.dart';
import 'package:vendor_banjari/Category.dart';
import 'package:vendor_banjari/Home.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return MenuUtama();
                },
              ));
            },
            child: Icon(
              Icons.home,
              size: 35,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CategoryPage();
                },
              ));
            },
            child: Icon(
              Icons.dashboard_rounded,
              size: 35,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CartPage();
                },
              ));
            },
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
