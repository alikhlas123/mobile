import 'package:flutter/material.dart';
import 'package:vendor_banjari/service/FirebaseApi.dart';
import 'package:vendor_banjari/service/FirebaseFile.dart';

class DetailStudio extends StatefulWidget {
  const DetailStudio({Key? key}) : super(key: key);

  @override
  State<DetailStudio> createState() => _detailStudio();
}

class _detailStudio extends State<DetailStudio> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll('file/detail/');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                final files = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Detail Alat Studio',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: files.length * 320.0,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        });
  }
}

Widget buildFile(BuildContext context, FirebaseFile file) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(file.url),
            fit: BoxFit.cover,
          )),
    );
