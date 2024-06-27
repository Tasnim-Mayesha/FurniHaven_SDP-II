import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:sdp2/features/seller/views/pages/controllers/AddEditProduct/add_edit_controller.dart';
import 'package:sdp2/utils/global_colors.dart';

class AddEditProductPage extends StatelessWidget {
  final AddEditProductController controller =
      Get.put(AddEditProductController());
  final Product? product;

  AddEditProductPage({this.product}) {
    if (product != null) {
      controller.setInitialValues(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleField(),
              SizedBox(height: 10),
              _buildImageField(),
              SizedBox(height: 10),
              _buildPriceAndQuantityFields(),
              SizedBox(height: 10),
              _buildMake3DCheckbox(),
              SizedBox(height: 10),
              Obx(() => controller.is3DEnabled.value
                  ? _build3DModelUploader()
                  : SizedBox.shrink()),
              SizedBox(height: 10),
              _buildCategoryDropdown(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Assume saveOrUpdateProduct() is defined in the controller
                  controller.saveOrUpdateProduct(product);
                },
                child:
                    Text(product == null ? 'Save Product' : 'Update Product'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Obx(() => TextField(
              onChanged: (value) => controller.title.value = value,
              controller: TextEditingController(text: controller.title.value),
              decoration: InputDecoration(hintText: 'Enter product title'),
            )),
      ],
    );
  }

  Widget _buildImageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Image',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Row(
          children: [
            Obx(() => Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: controller.imageFile.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(controller.imageFile.value!,
                              fit: BoxFit.cover),
                        )
                      : Center(child: Text('No Image')),
                )),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: controller.pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Icon(Icons.file_upload),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantityFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => TextField(
                    onChanged: (value) => controller.price.value = value,
                    controller:
                        TextEditingController(text: controller.price.value),
                    decoration: InputDecoration(hintText: 'Enter price'),
                  )),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => TextField(
                    onChanged: (value) => controller.quantity.value = value,
                    controller:
                        TextEditingController(text: controller.quantity.value),
                    decoration: InputDecoration(hintText: 'Enter quantity'),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMake3DCheckbox() {
    return Obx(() => CheckboxListTile(
          title: Text("Enable 3D Model"),
          value: controller.is3DEnabled.value,
          onChanged: controller.toggle3DEnabled,
        ));
  }

  Widget _build3DModelUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload 3D Model',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        ElevatedButton(
          onPressed: controller.pickModelFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          child: Text('Upload 3D Model'),
        ),
        SizedBox(height: 5),
        Obx(() => controller.modelFile.value != null
            ? Text('Model: ${controller.modelFile.value!.path}')
            : Text('No model uploaded')),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
          value: controller.category.value.isNotEmpty
              ? controller.category.value
              : null,
          hint: Text('Select category'),
          items: <String>['Electronics', 'Clothing', 'Books', 'Other']
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (value) => controller.category.value = value!,
        ));
  }
}
