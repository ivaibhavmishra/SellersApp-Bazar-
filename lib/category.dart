import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  final CollectionReference _firestore = FirebaseFirestore.instance.collection("Categories");
  String ref = 'Categories';

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore.add({"Category": name});//collection(ref).document(categoryId).setData({'category': name});
  }

  Future<List<DocumentSnapshot>> getCategories() =>
      _firestore.get().then((snaps) {
        return snaps.docs;
      });


  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      _firestore.where('Category', isEqualTo: suggestion).get().then((snap){
        return snap.docs;
      });

}