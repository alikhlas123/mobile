import 'package:flutter/material.dart';
import 'package:vendor_banjari/widget/DetailMusik.dart';

class DetailMusik2 extends StatelessWidget {
  const DetailMusik2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text("Vendor UKM Banjari"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailMusik(),
              ],
            ),
          ),
        ));
  }
}
