import 'package:flutter/material.dart';
import 'package:vendor_banjari/widget/DrawerWidget.dart';
import 'package:vendor_banjari/widget/LightingHor.dart';
import 'package:vendor_banjari/widget/MusikHor.dart';
import 'package:vendor_banjari/widget/ProfileDrawer.dart';
import 'package:vendor_banjari/widget/CustumNavBar.dart';
import 'package:vendor_banjari/widget/Header.dart';
import 'package:vendor_banjari/widget/Search.dart';
import 'package:vendor_banjari/widget/SoundHor.dart';
import 'package:vendor_banjari/widget/StudioHor.dart';

class MenuUtama extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Vendor UKM Banjari"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ProfileDrawers(),
      ),
      drawer: DrawerPage(),
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
                    Header(),
                    SizedBox(
                      height: 12,
                    ),
                    SearchWidget(),
                    SizedBox(
                      height: 12,
                    ),
                    StudioHor(),
                    SoundHor(),
                    MusikHor(),
                    LightingHor()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
