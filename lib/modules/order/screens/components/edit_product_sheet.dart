import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/providers/order_notifer_provider.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';
import 'package:media_design_assingment_app/utils/extensions/space_extension.dart';
import 'package:media_design_assingment_app/utils/helping_methods/helping_methods.dart';
import 'package:media_design_assingment_app/widgets/primary_button.dart';

class EditProductSheet extends ConsumerStatefulWidget {
  final ProductModel initialProduct;
  final int index;

  const EditProductSheet({
    super.key,
    required this.initialProduct,
    required this.index,
  });

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => this,
    );
  }

  @override
  ConsumerState<EditProductSheet> createState() => _EditProductSheetState();
}

class _EditProductSheetState extends ConsumerState<EditProductSheet> {
  late ProductModel _editedProduct;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _editedProduct = widget.initialProduct;
    _notesController = TextEditingController(text: _editedProduct.notes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _editedProduct = _editedProduct.copyWith(imagePath: image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _editedProduct = _editedProduct.copyWith(imagePath: null);
    });
  }

  void _saveChanges() {
    final updatedProduct = _editedProduct.copyWith(
      notes: _notesController.text,
    );
    ref
        .read(orderNotifierProvider.notifier)
        .updateProduct(widget.index, updatedProduct);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {}, // Prevent taps inside the dialog from closing it
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${AppStrings.edit} ${_editedProduct.name}',
                        style: AppTextStyles.regular.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                      20.vertical,
                      TextField(
                        onTapOutside: (_) => hideKeyboard(),
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: AppStrings.notes,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      20.vertical,
                      Row(
                        children: [
                          if (_editedProduct.imagePath != null &&
                              _editedProduct.imagePath!.isNotEmpty)
                            GestureDetector(
                              onTap: _removeImage,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(_editedProduct.imagePath!),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          Expanded(
                            child: PrimaryButton(
                              onPressed: _pickImage,
                              text:
                                  _editedProduct.imagePath != null
                                      ? AppStrings.changeImage
                                      : AppStrings.selectImage,
                            ),
                          ),
                        ],
                      ),
                      16.vertical,
                      PrimaryButton(
                        onPressed: _saveChanges,
                        text: AppStrings.save,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
