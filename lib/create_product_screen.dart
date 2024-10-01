import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_57_maadi/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  XFile? image;

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Product"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image == null
                  ? InkWell(
                      onTap: () async {
                        image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        setState(() {});

                        var ref = FirebaseStorage.instance
                            .ref()
                            .child("images/${image!.name}");

                        try {
                          await ref.putFile(File(image!.path));
                          imageUrl = await ref.getDownloadURL();
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: const CircleAvatar(radius: 50),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(image!.path)),
                    ),
              TextField(controller: nameController),
              TextField(controller: priceController),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection("products").add({
                    "name": nameController.text,
                    "price": priceController.text,
                    "image": imageUrl
                  }).then((val) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  });
                },
                child: const Text("Save Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
