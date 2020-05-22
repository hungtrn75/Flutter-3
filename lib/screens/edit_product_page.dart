import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  EditProductPage(this.product);
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusPriceNode = FocusNode();
  final _descriptionPriceNode = FocusNode();

  final _imageFocusNode = FocusNode();
  final validImageurl = RegExp(
      r'^https?://(?:[a-z0-9\-]+\.)+[a-z]{2,6}(?:/[^/#?]+)+\.(?:jpg|gif|png)$');
  final validPrice = RegExp(
    r'^(\+)?\d*(\.\d+)?$',
    caseSensitive: false,
    multiLine: false,
  );
  bool hasImg = false;
  bool isInit = true;
  bool isLoading = false;

  //Controller
  final _titleTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _imageTextController = TextEditingController();

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    if (widget.product != null) {
      _titleTextController.text = widget.product.title;
      _priceTextController.text = widget.product.price.toString();
      _descriptionTextController.text = widget.product.description;
      _imageTextController.text = widget.product.imageUrl;
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusPriceNode.dispose();
    _descriptionPriceNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageFocusNode.dispose();
    _imageTextController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm(_) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final productsProvider = Provider.of<Products>(context, listen: false);
    final updateProduct = Product(
        id: widget.product != null
            ? widget.product.id
            : DateTime.now().toString(),
        title: _titleTextController.text,
        description: _descriptionTextController.text,
        price: double.parse(_priceTextController.text),
        imageUrl: _imageTextController.text);
    if (widget.product != null) {
      await productsProvider.updateProduct(updateProduct);
    } else {
      await productsProvider.addProduct(updateProduct);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm('');
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _titleTextController,
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusPriceNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    onSaved: _saveForm,
                  ),
                  TextFormField(
                    focusNode: _focusPriceNode,
                    controller: _priceTextController,
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionPriceNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Price is required';
                      }
                      if (!validPrice.hasMatch(value)) {
                        return 'Please enter a valid price';
                      }
                      print(true);
                      return null;
                    },
                  ),
                  TextFormField(
                    focusNode: _descriptionPriceNode,
                    controller: _descriptionTextController,
                    decoration: InputDecoration(labelText: 'Description'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_imageFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: _imageTextController.text.isEmpty
                                ? Text('Enter a URL')
                                : Image.network(
                                    _imageTextController.text,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, e, _) {
                                      return Text(
                                        'Submit to preview image',
                                        style: TextStyle(fontSize: 14),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            focusNode: _imageFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                              suffixIcon: _imageTextController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.close),
                                      color: Colors.grey,
                                      onPressed: () {
                                        _imageTextController.clear();
                                        setState(() {
                                          hasImg = false;
                                        });
                                      },
                                    )
                                  : null,
                            ),
                            keyboardType: TextInputType.url,
                            onChanged: (text) {
                              if (text.isNotEmpty && !hasImg) {
                                setState(() {
                                  hasImg = true;
                                });
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Image URL is required';
                              }
                              if (!validImageurl.hasMatch(value)) {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                            controller: _imageTextController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: _saveForm),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.indigo,
                ),
              )
          ],
        ),
      ),
    );
  }
}
