import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_57_maadi/create_product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> products = [];

  _getData() async {
    var data = await FirebaseFirestore.instance.collection("products").get();
    for (var element in data.docs) {
      products.add(element.data());
    }
    setState(() {});
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateProductScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(products[index]["image"]),
              title: Text(products[index]["name"]),
              subtitle: Text(products[index]["price"]),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 var data =
//                     await FirebaseFirestore.instance.collection("users").get();
//                 for (var element in data.docs) {
//                   print(element.id);
//                   print(element.data());
//                 }
//               },
//               child: const Text("Get All Data"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 var data = await FirebaseFirestore.instance
//                     .collection("users")
//                     .doc("LxCkmCSUQd411nz1qCfc")
//                     .get();

//                 print(data.id);
//                 print(data.data());
//               },
//               child: const Text("Get One Item"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 var data =
//                     await FirebaseFirestore.instance.collection("users").add({
//                   "name": "mohamed",
//                   "email": "mo@gmail.com",
//                   "password": "123456",
//                   "phone": ""
//                 });

//                 print(data.id);
//               },
//               child: const Text("Create New Item"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection("users")
//                       .doc("0WzbSPpKJ3uClIghqUAG")
//                       .update({
//                     "email": "ali@gmail.com",
//                     "name": "ali",
//                     "password": "123456789",
//                   });
//                 } catch (e) {
//                   print("Document not found");
//                 }
//               },
//               child: const Text("Edit Data"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection("users")
//                       .doc("0WzbSPpKJ3uClIghqUAG")
//                       .delete();
//                 } catch (e) {
//                   print(e.toString());
//                 }
//               },
//               child: const Text("Delete Data"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
