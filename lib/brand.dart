import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import 'dart:convert';
class BrandService{
  final CollectionReference _firestore = FirebaseFirestore.instance.collection("Brands");
  String ref = 'Brands';

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    _firestore.add({"Brand": name}) ; // collection(ref).document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() => _firestore.get().then((snaps){
    print(snaps.docs.length);
    return snaps.docs;
  });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      _firestore.where('Brand', isEqualTo: suggestion).get().then((snap){
        return snap.docs;
      });
}