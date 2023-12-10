import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/Cart.dart';
import 'package:vendor_banjari/Home.dart';
import 'package:vendor_banjari/Login.dart';
import 'package:vendor_banjari/Order.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: Image.asset('assets/banjari-01.png'),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Home",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return MenuUtama();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "My Cart",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return CartPage();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "My Order",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return OrderPage();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      _auth.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
