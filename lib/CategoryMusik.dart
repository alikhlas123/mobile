import 'package:flutter/material.dart';
import 'package:vendor_banjari/widget/MusikVer.dart';

class CategoryMusik extends StatelessWidget {
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
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    MusikVer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
