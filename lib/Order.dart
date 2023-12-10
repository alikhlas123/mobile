import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_banjari/Confirm.dart';
import 'package:vendor_banjari/widget/DrawerWidget.dart';
import 'package:vendor_banjari/Cart.dart';

class OrderPage extends StatelessWidget {
  Future<int> calculateSubtotal(List<DocumentSnapshot> documents) async {
    int subtotal = 0;
    for (var doc in documents) {
      var hargaString = doc['harga'] as String;
      var harga = int.parse(hargaString.replaceAll(RegExp(r'[^0-9]'), ''));
      subtotal += harga;
    }
    return subtotal;
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
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Your Order",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('cart').get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  var documents = snapshot.data!.docs;

                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          var doc =
                              documents[index].data() as Map<String, dynamic>;
                          var imageUrl = doc['image'] as String?;
                          var hargaString = doc['harga'] as String;

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
                                  padding: EdgeInsets.all(2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc['nama'] ?? 'Nama',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Rp.$hargaString', // Display the item price
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total"),
                                  FutureBuilder(
                                    // Calculate subtotal after fetching data
                                    future: calculateSubtotal(documents),
                                    builder: (context,
                                        AsyncSnapshot<int> subtotalSnapshot) {
                                      if (subtotalSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (subtotalSnapshot.hasError) {
                                        return Text(
                                            'Error: ${subtotalSnapshot.error}');
                                      }
                                      return Text(
                                          "Rp.${subtotalSnapshot.data}");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ongkir"),
                                  Text(
                                      "Rp.100000"), // Assuming fixed shipping cost
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total"),
                                  FutureBuilder(
                                    future: calculateSubtotal(documents),
                                    builder: (context,
                                        AsyncSnapshot<int> totalSnapshot) {
                                      if (totalSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (totalSnapshot.hasError) {
                                        return Text(
                                            'Error: ${totalSnapshot.error}');
                                      }
                                      int shippingCost = 100000;
                                      int total =
                                          totalSnapshot.data! + shippingCost;
                                      return Text("Rp.$total");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return CartPage();
                                  },
                                ));
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                int subtotal =
                                    await calculateSubtotal(documents);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ConfirmPage(subtotal: subtotal);
                                    },
                                  ),
                                );
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
