//import 'dart:html';
import 'dart:io';
//import 'dart:typed_data';

//import 'package:e_commerce_admin_side/Pick_image.dart';
import 'package:e_commerce_admin_side/Pick_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
//import 'Pick_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final CollectionReference _product =
      FirebaseFirestore.instance.collection("Product detail");

  String imageUrl2 = "";
  String imageUrl3 = "";
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  List<DocumentSnapshot> Brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> Categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> CategoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> BrandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = "";
  String _currentBrand = "";
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  String _image1 = "";
  String _image2 = "";
  String _image3 = "";
  String imageUrl1 = "";
  String SelectedCategories ="0";
  String SelectedBrands = "0";
  String _category = "";
  bool isCheckedpremium =false;
  bool isCheckedbest = false;

  void initstate() {
    Firebase.initializeApp();
    super.initState();
  }

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                            color: grey.withOpacity(0.5), width: 2.5),
                      ),
                      onPressed: () async {
                        //_selectImage(ImagePicker.pickImage(source:ImageSource.gallery) , 1);
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');
                        if (file == null) return;
                        //return Image.(imageUrl, fit: BoxFit.fill, width: double.infinity,)
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirimage =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirimage.child(uniqueFileName);

                        try {
                          await referenceImageToUpload
                              .putFile(File(file!.path));
                          imageUrl1 =
                              await referenceImageToUpload.getDownloadURL();
                          _image1 = imageUrl1;
                        } catch (error) {}
                        print("vaibhav");
                        print(imageUrl1);
                        //print(_image1);
                        displayImage1();
                      },
                      child: displayImage1(),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                          ),
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            print('${file?.path}');
                            if (file == null) return;
                            //return Image.(imageUrl, fit: BoxFit.fill, width: double.infinity,)
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirimage =
                                referenceRoot.child('images');

                            Reference referenceImageToUpload =
                                referenceDirimage.child(uniqueFileName);

                            try {
                              await referenceImageToUpload
                                  .putFile(File(file!.path));
                              imageUrl2 =
                                  await referenceImageToUpload.getDownloadURL();
                              _image2 = imageUrl2;
                            } catch (error) {}
                            print("vaibhav");
                            print(imageUrl2);
                            //print(_image1);
                            displayImage2();
                            Fluttertoast.showToast(msg: 'Image Added');
                          },
                          child: displayImage2()),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                          ),
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            print('${file?.path}');
                            if (file == null) return;
                            //return Image.(imageUrl, fit: BoxFit.fill, width: double.infinity,)
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirimage =
                                referenceRoot.child('images');

                            Reference referenceImageToUpload =
                                referenceDirimage.child(uniqueFileName);

                            try {
                              await referenceImageToUpload
                                  .putFile(File(file!.path));
                              imageUrl3 =
                                  await referenceImageToUpload.getDownloadURL();
                              _image3 = imageUrl3;
                              Fluttertoast.showToast(msg: 'Image Added');
                            } catch (error) {}
                            print("vaibhav");
                            print(imageUrl3);
                            //print(_image1);
                            displayImage3();
                            Fluttertoast.showToast(msg: 'Image Added');
                          },
                          child: displayImage3()),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'enter a product name with 10 characters at maximum',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(hintText: 'Product name'),
                  validator: (value) {
                    if (value == null) {
                      return 'You must enter the product name';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Categories')
                              .snapshots(),
                          builder: (context, snapshots) {
                            List<DropdownMenuItem> Items = [];
                            if (!snapshots.hasData) {
                              const CircularProgressIndicator();
                            } else {
                              final Categoriess =
                                  snapshots.data?.docs.reversed.toList();

                              Items.add(
                                  const DropdownMenuItem(
                                  value: "0",
                                  child: Text("Category" , style: TextStyle(color: Colors.red),) ));
                              for (var Categories in Categoriess!) {
                                Items.add(DropdownMenuItem(
                                    value: Categories['Category'],


                                    child: Text(Categories['Category'])));

                              }


                              //_category = Categories[1]["Category"];

                            }

                            return DropdownButton(items: Items, onChanged: (CategoryValue ){
                              setState(()  {
                                SelectedCategories = CategoryValue;
                                //print(Categories[CategoryValue ] ['Category'])as String;
                                // _category = Categories[1]["Category"];
                                // print(_category);
                              });

                            },

                              value: SelectedCategories,

                              //_category = CategoryVa
                              //_category = Categories[value]['Category'] as String;
                            isExpanded: false,
                            );


                          }),
                    ),
                  ),

                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Brands')
                          .snapshots(),
                      builder: (context, snapshots) {
                        List<DropdownMenuItem> Items = [];
                        if (!snapshots.hasData) {
                          const CircularProgressIndicator();
                        } else {
                          final Brandss =
                          snapshots.data?.docs.reversed.toList();

                          Items.add(
                              const DropdownMenuItem(
                                  value: "0",
                                  child: Text("Brand" , style: TextStyle(color: Colors.red),) ));
                          for (var Brands in Brandss!) {
                            Items.add(DropdownMenuItem(
                                value: Brands['Brand'],
                                child: Text(Brands['Brand'])));
                          }

                        }
                        return DropdownButton(items: Items, onChanged: (BrandValue){
                          setState(() {
                            SelectedBrands = BrandValue;
                          });
                          print(BrandValue);
                        },

                          value: SelectedBrands,
                          isExpanded: false,
                        );
                      }),
                  ), )

                ],
              )


              ,
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: quantity,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Quantity",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "must enter quantity";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: price,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Price",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "must enter quantity";
                    }
                  },
                ),
              ),


              Row(
                children: <Widget>[
                 // Expanded(
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(value: isCheckedpremium, onChanged: (bool? newValue) { setState(() {
                        isCheckedpremium = newValue ?? false;
                      });}),
                    ),
                  //),
                  Text('Our Premiums'),
                 // Expanded(
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(value: isCheckedbest, onChanged: (bool? newValue) { setState(() {
                        isCheckedbest = newValue ?? false;
                      });}),
                  //  ),
                  ),
                  Text('Best Offers'),


                ],
              ),


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    elevation: 0.0),
                onPressed: () {
                  _product.add({
                    "Product_Name": productNameController.text,
                    "Quantity": quantity.text,
                    "Price": price.text,
                    "Image1": imageUrl1,
                    "Image2": imageUrl2,
                    "Image3": imageUrl3,
                    "Category": SelectedCategories,
                    "Brand": SelectedBrands,
                    "Our_premium": isCheckedpremium,
                    "Best_Offer": isCheckedbest,

                  });Fluttertoast.showToast(msg: "Product added Successfully") ;
                },
                child: Text(
                  'add product',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget displayImage1() {
    setState(() {
      _image1;
    });
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // print(_image1);
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
          child: Image.network(
            _image1,
            fit: BoxFit.fill,
            width: double.infinity,
          ));
    }
  }

  Widget displayImage2() {
    setState(() {
      _image2;
    });
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // print(_image1);
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
          child: Image.network(
            _image2,
            fit: BoxFit.fill,
            width: double.infinity,
          ));
    }
  }

  Widget displayImage3() {
    setState(() {
      _image3;
    });
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // print(_image1);
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
          child: Image.network(
            _image3,
            fit: BoxFit.fill,
            width: double.infinity,
          ));
    }
  }
}
