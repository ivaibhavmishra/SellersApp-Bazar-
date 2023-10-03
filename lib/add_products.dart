//import 'dart:html';
import 'dart:io';
//import 'dart:typed_data';

//import 'package:e_commerce_admin_side/Pick_image.dart';
import 'package:e_commerce_admin_side/Pick_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
//import 'Pick_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
String imageUrl ="";
String image = "";
class ImageProvider with ChangeNotifier{
  String file = "";



  selectImageFromgallary()async{
    ImagePicker imagePicker = ImagePicker();
    XFile ? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    if (file == null) return;
      //return Image.(imageUrl, fit: BoxFit.fill, width: double.infinity,)
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirimage = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirimage.child(uniqueFileName);

    try{
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();

    }
    catch(error){
    }
    print("vaibhav");
    print(imageUrl );

  }



}

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final CollectionReference _product = FirebaseFirestore.instance.collection("Product Detail");



  //String imageUrl2 ="";
  //String imageUrl3 ="";
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantity = TextEditingController();
  List<DocumentSnapshot> Brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> Categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> CategoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> BrandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory ="";
  String _currentBrand ="";
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
   //String file ="" ;
  // late File _Image1;
  // late File _Image2;
  // late File _Image3;




  void initstate(){

    Firebase.initializeApp();
    super.initState();
  }
  @override
  void initState() {
    _getCategories();
//    _getBrands();
    CategoriesDropDown = getCategoriesDropdown();
  }

  getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items =[];
    for(int i = 0; i < Categories.length; i++){
      setState(() {
        CategoriesDropDown.insert(0, DropdownMenuItem(child: Text(Categories[i]['category']),
            value: Categories[i]['category']));
      });
    }
    print(items.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(Icons.close, color: black,),
        title: Text("add product", style: TextStyle(color: black),),
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

                      child: ChangeNotifierProvider<ImageProvider>(

                        create: (context)=> ImageProvider(),

                        child : Consumer<ImageProvider>(
                          builder: (context, provider , child){
                             return Column(
                               children: [
                                 Text(provider.file),
                                 TextButton(
                                    style: TextButton.styleFrom(side:  BorderSide(color: grey.withOpacity(0.5), width: 2.5),),

                                    onPressed: ()async{
                                      provider.selectImageFromgallary();

                                    },

                                    child:displayimage1()
                            ),
                               ],
                             );
                          },
                        )







                        // Column(
                        //   children: [
                        //     image == ""
                        //     ? Image.asset("assets/frame3.jpg" , height: 70 , width: 14, fit: BoxFit.fill,)
                        //         : Image.file(File(image), height: 70, width: 14, fit: BoxFit.fill,),
                        //     ElevatedButton(onPressed: (){selectImageFromgallary(); image = selectImageFromgallary();}, child: Text("add"))
                        //   ],

                            // style: TextButton.styleFrom(side:  BorderSide(color: grey.withOpacity(0.5), width: 2.5),),
                            // onPressed: () async {
                            //   displayimage1();
                            //
                            // }

                           // ,child: IconButton (onPressed: () async{ image= await selectImageFromgallary();}, icon: Icon(Icons.add))

                      ))),






                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(side:  BorderSide(color: grey.withOpacity(0.5), width: 2.5),),
                        onPressed: ()async{
                          // ImagePicker imagePicker = ImagePicker();
                          // XFile ? file = await imagePicker.pickImage(source: ImageSource.gallery);
                          // print('${file?.path}');
                          // if (file == null) return;
                          //
                          // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                          //
                          // Reference referenceRoot = FirebaseStorage.instance.ref();
                          // Reference referenceDirimage = referenceRoot.child('images');
                          //
                          // Reference referenceImageToUpload = referenceDirimage.child(uniqueFileName);
                          //
                          // try{
                          //   await referenceImageToUpload.putFile(File(file!.path));
                          //   imageUrl2 = await referenceImageToUpload.getDownloadURL();
                          //
                          // }
                          // catch(error){}
                          //

                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(Icons.add, color: grey,),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(side:  BorderSide(color: grey.withOpacity(0.5), width: 2.5),),
                        onPressed: ()async{
                          // ImagePicker imagePicker = ImagePicker();
                          // XFile ? file = await imagePicker.pickImage(source: ImageSource.gallery);
                          // print('${file?.path}');
                          // if (file == null) return;
                          //
                          // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                          //
                          // Reference referenceRoot = FirebaseStorage.instance.ref();
                          // Reference referenceDirimage = referenceRoot.child('images');
                          //
                          // Reference referenceImageToUpload = referenceDirimage.child(uniqueFileName);
                          //
                          // try{
                          //   await referenceImageToUpload.putFile(File(file!.path));
                          //   imageUrl3 = await referenceImageToUpload.getDownloadURL();
                          //
                          // }
                          // catch(error){}

                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(Icons.add, color: grey,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('enter a product name with 10 characters at maximum',textAlign: TextAlign.center ,style: TextStyle(color: red, fontSize: 12),),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      hintText: 'Product name'
                  ),
                  validator: (value){
                    if(value == null){
                      return 'You must enter the product name';
                    }else if(value.length > 10){
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category

              Visibility(
                visible: _currentCategory != null || _currentCategory == '',
                child: Text(_currentCategory ?? "null", style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: 'add category'
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _categoryService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['Category']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentCategory = suggestion['Category'];
                    });
                  },
                ),
              ),

//            select brand

              Visibility(
                visible: _currentBrand != null || _currentBrand == '',
                child: Text(_currentBrand ?? "null", style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: 'add brand'
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _brandService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['Brand']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentBrand = suggestion['Brand'];
                    });
                  },
                ),
              ),
              Padding(padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: quantity,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: "Quantity",
                ),
                validator: (value){
                  if(value== null){
                    return"must enter quantity";
                  }
                },
              ),
              ),

              ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red,
              onPrimary: Colors.white,
              elevation: 0.0 ),

                child: Text('add product',style: TextStyle(color: Colors.white),),
                onPressed: (){
                _product.add({"Product Name" : productNameController.text, "Quantity": quantity.text , "Image" : imageUrl });
                },
              )
            ],
           ),
        ),
      ),
    );
  }

  _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      Categories = data;
      print(Categories.length);
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  // void selectImage() async{
  //   _Image1  = await pickImage(ImageSource.gallery);
  //    _Image2 = await pickImage(ImageSource.gallery);
  //   _Image3 = await pickImage(ImageSource.gallery);
  // }

 Widget displayimage1(){
    if (image == "" ){
      return Padding(padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child:  Icon(Icons.add , color: Colors.grey),
      );
    }else{
      return Image.file(File(image), fit: BoxFit.fill, width: double.infinity,);
    }


  }

 // selectImageFromgallary()async{
 //   ImagePicker imagePicker = ImagePicker();
 //   XFile ? file = await imagePicker.pickImage(source: ImageSource.gallery);
 //   print('${file?.path}');
 //   if (file == null) return;
 //
 //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
 //
 //   Reference referenceRoot = FirebaseStorage.instance.ref();
 //   Reference referenceDirimage = referenceRoot.child('images');
 //
 //   Reference referenceImageToUpload = referenceDirimage.child(uniqueFileName);
 //
 //   try{
 //     await referenceImageToUpload.putFile(File(file!.path));
 //     imageUrl = await referenceImageToUpload.getDownloadURL();
 //
 //   }
 //   catch(error){
 //   }
 //   print("vaibhav");
 //   print(imageUrl );}


}