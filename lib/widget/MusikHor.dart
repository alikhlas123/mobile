import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_banjari/service/FirestoreService.dart';
import 'package:vendor_banjari/Musik2.dart';

class MusikHor extends StatefulWidget {
  const MusikHor({Key? key}) : super(key: key);

  @override
  State<MusikHor> createState() => _MusikHorState();
}

class _MusikHorState extends State<MusikHor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sewa Alat Musik',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 3,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            height: 200,
            child: StreamBuilder<QuerySnapshot>(
              stream: FireStoreServiceMusik().getMusik(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  List<DocumentSnapshot> musikList = snapshot.data!.docs;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, _) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot = musikList[index];
                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      return Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return Musik2(
                                    data: data,
                                  );
                                },
                              ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 130,
                                  child: Image.network(
                                    data['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['nama'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        data['harga'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
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
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
