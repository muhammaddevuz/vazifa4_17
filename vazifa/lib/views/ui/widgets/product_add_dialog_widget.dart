import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/cubits/product/product_cubit.dart';
import 'package:vazifa/data/models/product.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddProductDialog extends StatefulWidget {
  final Product? product;

  const AddProductDialog({Key? key, this.product}) : super(key: key);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _image;
  late String _price;

  @override
  void initState() {
    super.initState();
    _title = widget.product?.title ?? '';
    _image = widget.product?.image ?? '';
    _price = widget.product?.price ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.product == null ? 'Mahsulot qo\'shish' : 'Mahsulotni tahrirlash',
        style: TextStyle(fontSize: 14),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 65,
              width: double.infinity,
              child: TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, name kiriting';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(
                    () {
                      _title = value;
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 65,
              width: double.infinity,
              child: TextFormField(
                initialValue: _image,
                decoration: InputDecoration(
                  labelText: 'Images',
                  labelStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _image = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ZoomTapAnimation(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green.shade300,
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  final product = Product(
                    id: widget.product?.id ?? DateTime.now().toString(),
                    title: _title,
                    image: _image.isNotEmpty ? _image : null,
                    price: _price.isNotEmpty ? _price : '',
                  );
                  if (widget.product == null) {
                    context.read<ProductCubit>().addProduct(product);
                  } else {
                    context.read<ProductCubit>().updateProduct(product);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green.shade300,
                ),
                child: Center(
                  child: Text(widget.product == null ? 'Add' : 'Save'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
