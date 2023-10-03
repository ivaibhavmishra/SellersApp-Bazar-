import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin.dart';
import 'brand.dart';
import 'category.dart';
import 'add_products.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Admin()
      // duration:10 ,
    );

  }
}