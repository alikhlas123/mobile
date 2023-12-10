import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_banjari/service/utils.dart';

class ProfileDrawers extends StatefulWidget {
  const ProfileDrawers({Key? key}) : super(key: key);
  @override
  _ProfileDrawersState createState() => _ProfileDrawersState();
}

class _ProfileDrawersState extends State<ProfileDrawers> {
  Uint8List? _image;
  String _imageUrl = "";

  @override
  void initState() {
    super.initState();
    _loadImageUrlFromFirestore();
  }

  void _loadImageUrlFromFirestore() async {
    String userId = "user_id";
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final imageUrl = userDoc.get('profileImageUrl');

      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  void _selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });

    if (_image != null) {
      String imageUrl =
          await _uploadImageToStorage("profile_image.jpg", _image!);
      await _saveImageUrlToFirestore(imageUrl);

      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<String> _uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('imageProfile/').child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _saveImageUrlToFirestore(String imageUrl) async {
    String userId = "user_id";

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profileImageUrl': imageUrl,
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'profileImageUrl': imageUrl,
      });
    }

    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.amber),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Profile",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              _imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(_imageUrl),
                    )
                  : _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlkpLG2SkJC6gxZcUlSEK3ArJmxls84yN7B5fITkM&s"),
                        ),
              Positioned(
                child: IconButton(
                  onPressed: _selectImage,
                  icon: Icon(Icons.add_a_photo),
                ),
                bottom: -10,
                left: 80,
              )
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('register').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Container(
                height: 200,
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;

                    return ListTile(
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nama :",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                data['name'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Alamat :",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                data['address'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No.HP :",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                data['phone'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
