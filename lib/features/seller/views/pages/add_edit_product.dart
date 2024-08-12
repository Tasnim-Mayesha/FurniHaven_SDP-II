import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:sdp2/features/seller/views/pages/controllers/AddEditProduct/add_edit_controller.dart';
import 'package:sdp2/utils/global_colors.dart';

class AddEditProductPage extends StatelessWidget {
  final AddEditProductController controller =
  Get.put(AddEditProductController());
  final Product? product;

  AddEditProductPage({super.key, this.product}) {
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleField(),
                  const SizedBox(height: 10),
                  _buildImageField(),
                  const SizedBox(height: 10),
                  _buildPriceAndQuantityFields(),
                  const SizedBox(height: 10),
                  _buildDiscountField(),
                  const SizedBox(height: 10),
                  _buildDescriptionField(),
                  const SizedBox(height: 10),
                  _buildMake3DCheckbox(),
                  const SizedBox(height: 10),
                  Obx(() => controller.is3DEnabled.value
                      ? _build3DModelUploader()
                      : const SizedBox.shrink()),
                  const SizedBox(height: 10),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.saveOrUpdateProduct(product);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                        product == null ? 'Save Product' : 'Update Product'),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: Container(
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller.titleController,
          decoration: const InputDecoration(hintText: 'Enter product title'),
        ),
      ],
    );
  }

  Widget _buildImageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add Image',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
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
                  : const Center(child: Text('No Image')),
            )),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: controller.pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Icon(Icons.file_upload),
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
              const Text('Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: controller.priceController,
                decoration: const InputDecoration(hintText: 'Enter price'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Quantity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: controller.quantityController,
                decoration: const InputDecoration(hintText: 'Enter quantity'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Discount (%)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller.discountController,
          decoration:
          const InputDecoration(hintText: 'Enter discount percentage'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller.descriptionController,
          maxLines: 3,
          decoration:
          const InputDecoration(hintText: 'Enter product description'),
        ),
      ],
    );
  }

  Widget _buildMake3DCheckbox() {
    return Obx(() => CheckboxListTile(
      title: const Text("Enable 3D Model"),
      value: controller.is3DEnabled.value,
      onChanged: controller.toggle3DEnabled,
    ));
  }

  Widget _build3DModelUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload 3D Model',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: controller.pickModelFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          child: const Text('Upload 3D Model'),
        ),
        const SizedBox(height: 5),
        Obx(() => controller.modelFile.value != null
            ? Text('Model: ${controller.modelFile.value!.path}')
            : const Text('No model uploaded')),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
      value: controller.category.value.isNotEmpty
          ? controller.category.value
          : null,
      hint: const Text('Select category'),
      items: <String>['Sofas','Beds','Dining','Shoe Rack','Study Table','Chair','Cupboard','Bookshelf']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => controller.category.value = value!,
    ));
  }
}
