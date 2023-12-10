// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class SlidableDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       actionPane: SlidableDrawerDelegate(),
//       actionExtentRatio: 0.25,
//       child: ListView(
//         children: [
//           Container(
//             color: Colors.white,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.home),
//                     title: Text('Home'),
//                     onTap: () {
//                       // Tambahkan logika untuk navigasi ke halaman Home
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text('Settings'),
//                     onTap: () {
//                       // Tambahkan logika untuk navigasi ke halaman Settings
//                       Navigator.pop(context);
//                     },
//                   ),
//                   // Tambahkan item-menu sidebar sesuai kebutuhan
//                   ListTile(
//                     leading: Icon(Icons.shopping_cart),
//                     title: Text('Sewa Barang'),
//                     onTap: () {
//                       // Tambahkan logika untuk navigasi ke halaman Sewa Barang
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.history),
//                     title: Text('Riwayat Sewa'),
//                     onTap: () {
//                       // Tambahkan logika untuk navigasi ke halaman Riwayat Sewa
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
