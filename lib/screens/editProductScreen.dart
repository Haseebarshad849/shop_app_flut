import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
// import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  TextEditingController _imageUrlController = TextEditingController();
  var _initValues = {
    'title': '',
    'description':'',
    'price': '',
    'imageUrl': ''
  };
  var _isInitState = true;

  var _editedProduct =
  Product(id: null,
      title: '',
      description: '',
      price: 0,
      imageUrl: '');

  @override
  void dispose() {
    _imageUrlController.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(_isInitState){
    final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId !=null){
      _editedProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text=_editedProduct.imageUrl;
      }
    }
    _isInitState=false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
    setState(() {});
  }
}

void _saveForm() {
  var isValid = _formKey.currentState.validate();
  if(!isValid){
    return;
  }
  _formKey.currentState.save();
  if(_editedProduct.id!=null){
    Provider.of<Products>(context,listen: false).updateProduct(_editedProduct.id,_editedProduct);
  }else{
  Provider.of<Products>(context,listen: false).addProduct(_editedProduct);
  }
  Navigator.pop(context);
}

@override
Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Product'),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () => _saveForm(),
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: ListView(
          // itemBuilder: ,
          children: [
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product title';
                }
                if (value.length < 3) {
                  return 'Please enter correct name';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  title: value,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product price';
                }
                if (double.tryParse(value) == null) {
                  return 'Price must be in number';
                }
                if (double.parse(value) <= 0) {
                  return 'Price of the product cannot be less than 1';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: double.parse(value),
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),

            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product description';
                }
                if (value.length < 10) {
                  return 'Description of the product should be atleast 10 characters long ';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: value,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
              // onChanged: (val)=> ,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  height: 100,
                  width: 100,
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                  child: _imageUrlController.text.isEmpty
                      ? Text('Choose a photo')
                      : FittedBox(
                    child: Image.network(_imageUrlController.text),
                    fit: BoxFit.contain,
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                    ),
                    keyboardType: TextInputType.url,
                    focusNode: _imageUrlFocusNode,
                    controller: _imageUrlController,
                    onSaved: (value) {
                      _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: value,
                        isFavorite: _editedProduct.isFavorite,
                      );
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Image URL must not be empty';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Invalid URL';
                      }
                      if (!value.endsWith('.png') && !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
                        return 'Mention the extention of image e.g. \'.jpg, .jpeg or .png\'';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _saveForm(),
                    // onChanged: (val)=> ,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}}
