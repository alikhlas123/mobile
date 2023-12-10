import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/service/FirestoreService.dart';
import 'package:vendor_banjari/Sound2.dart';

class SoundVer extends StatefulWidget {
  const SoundVer({Key? key}) : super(key: key);

  @override
  State<SoundVer> createState() => _SoundVerState();
}

class _SoundVerState extends State<SoundVer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireStoreServiceSound().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            List<DocumentSnapshot> studList = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pilihan Sewa Studio',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: studList.length * 320.0,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: studList.length,
                    separatorBuilder: (context, _) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot = studList[index];
                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      return Card(
                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            data['nama'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Sound2(
                                  data: data,
                                );
                              },
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
  }
}
