import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/Order.dart';
import 'package:vendor_banjari/widget/DrawerWidget.dart';
import 'package:vendor_banjari/Home.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> counters = [];
  List<DocumentSnapshot> documents = [];

  void removeItemFromCart() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(documents[0].id)
        .delete();

    setState(() {
      documents.removeAt(0);
      counters.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Vendor UKM Banjari"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Cart",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('cart').get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  documents = snapshot.data!.docs;
                  counters = List.generate(documents.length, (index) => 1);

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      var doc = documents[index].data() as Map<String, dynamic>;
                      var imageUrl = doc['image'] as String?;
                      return Container(
                        padding: EdgeInsets.all(20),
                        width: 340,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      imageUrl ?? 'URL_PLACEHOLDER'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doc['nama'] ?? 'Nama',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    doc['harga'] ?? 'harga',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return MenuUtama();
                          },
                        ));
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        removeItemFromCart();
                      },
                      child: Text(
                        "Remove",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return OrderPage();
                          },
                        ));
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
