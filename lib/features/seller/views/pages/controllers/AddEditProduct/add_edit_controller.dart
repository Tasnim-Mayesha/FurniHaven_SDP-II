import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sdp2/features/seller/models/Product.dart';

class AddEditProductController extends GetxController {
  var title = ''.obs;
  var imageFile = Rx<File?>(null);
  var modelFile = Rx<File?>(null); // To handle 3D model file
  var price = ''.obs;
  var quantity = ''.obs;
  var is3DEnabled = false.obs;
  var category = ''.obs;
  final ImagePicker picker = ImagePicker();

  void setInitialValues(Product? product) {
    if (product != null) {
      title.value = product.title;
      imageFile.value = product.imageFile;
      price.value = product.price.toString();
      quantity.value = product.quantity.toString();
      is3DEnabled.value = product.is3DEnabled;
      category.value = product.category;
      modelFile.value = product.modelFile; // Set the 3D model file if available
    }
  }

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void pickModelFile() async {
    try {
      // Check storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        // Request permission
        var result = await Permission.storage.request();
        if (!result.isGranted) {
          print("Storage permission not granted");
          return;
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        modelFile.value = file;
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Failed to pick file: $e");
    }
  }

  void toggle3DEnabled(bool? value) {
    if (value != null) {
      is3DEnabled.value = value;
    }
  }

  void saveOrUpdateProduct(Product? product) {
    // Save or update product
  }
}
