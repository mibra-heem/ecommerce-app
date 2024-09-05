import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productBrandController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  String imageUrl = '';

  final databaseReference = FirebaseFirestore.instance.collection('products');

  Future<void> selectImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        selectedImage.value = File(file.path);
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  Future<void> addProduct() async {
    if (selectedImage.value == null) {
      print('No image selected.');
      return;
    }

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference reference = FirebaseStorage.instance.ref();
    Reference imageReference = reference.child('products');
    Reference referenceImageUpload = imageReference.child(uniqueFileName);

    try {
      await referenceImageUpload.putFile(selectedImage.value!);
      imageUrl = await referenceImageUpload.getDownloadURL();
      print('Image uploaded successfully: $imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
      return;
    }

    try {
      await databaseReference.add({
        'name': productNameController.text,
        'price': productPriceController.text,
        'description': productDescriptionController.text,
        'image': imageUrl,
        'brand': productBrandController.text
      });
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
    }finally {
      selectedImage.value = null;
      productNameController.clear();
      productPriceController.clear();
      productDescriptionController.clear();
      productBrandController.clear();
    }
  }
}
