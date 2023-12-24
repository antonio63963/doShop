import 'dart:io';

import 'package:doshop_app/utils/photo.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/info_row.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/menu_product.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/unit_and_tag.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/widgets/exports.dart';

import 'widgets/additional_info.dart';

class ProductDetailsScreen extends StatefulWidget {
  static String routeName = '/ProductDetailsScreen';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isLoaded = false;
  bool _isInit = false;

  ProductDetailsScreenArguments? _screenArguments;
  ProductProvider? _productProvider;

  File? imageFile;

  Int8List? _bytes;

  Future<Int8List?> _getBytes(String imageUrl) async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    // _bytes = data.buffer.asInt8List();
    logger.i('GET BYTE: $data');
    return data.buffer.asInt8List();
  }

  void pickCamera(ImageSource imgSrc) async {
    ImagePicker().pickImage(source: imgSrc).then((image) {
      if (image == null &&
          _productProvider == null &&
          _productProvider?.productDetails == null) return;
      saveImage(context, image!, _productProvider!.productDetails!);

      // logger.d('COnverted img: $imgString');
    }).catchError((err) {
      logger.e('Pick image Error!!! $err');
    });
  }

  Future<void> saveImage(
      BuildContext context, XFile image, Product product) async {
    if (product.id == null) return;
    String imgString =
        PhotoService.base64String(File(image!.path).readAsBytesSync());
    _productProvider?.savePhoto(
      context,
      Photo(
        photo: imgString,
        productId: product.id!,
        categoryId: product.catId,
      ),
    );
  }

  Future<void> refresh() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductById(context, _screenArguments!.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _screenArguments = ModalRoute.of(context)?.settings.arguments
          as ProductDetailsScreenArguments;
      _productProvider = Provider.of<ProductProvider>(context);
      _productProvider?.getProductById(context, _screenArguments!.id).then(
            (value) => setState(
              () {
                _isInit = true;
              },
            ),
          );
    }
    _isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).productDetails;
    logger.i('Product Details: ${product?.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_screenArguments?.title ?? 'Не определен'} ${_screenArguments?.subtitle ?? ''}',
        ),
        actions: [
          if (product != null && product.id != null && _screenArguments != null)
            MenuProduct(
              colorBg: _screenArguments!.colorBg,
              product: product,
              context: context,
            )
        ],
      ),
      body: !_isLoaded
          ? const Loading()
          : PageContentWrapper(
              paddingHorizontal: AppPadding.bodyHorizontal,
              onRefresh: refresh,
              widgets: [
                GestureDetector(
                  onTap: () => pickCamera(ImageSource.camera),
                  child: Card(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: product != null && product.photos!.isEmpty
                          ? Icon(
                              Icons.photo,
                              size: 100,
                              color: MyColors.primary,
                            )
                          : ClipRRect(borderRadius: BorderRadius.all(Radius.circular(5)), child: PhotoService.imageFromBase64String(product!.photos![0].photo),)
                    ),
                  ),
                ),
                // Image.memory(Uint8List.fromList(product.photos[idx]))
                InfoRow(
                  labelText: 'Категория:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: product?.catImg ?? DefaultValues.icon,
                  text:
                      '${product?.categoryTitle} ${product?.categorySubtitle}',
                  paddingBottom: 32,
                  paddingTop: 32,
                ),
                InfoRow(
                  labelText: 'Короткое описание:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: product?.icon ?? DefaultValues.icon,
                  text: _screenArguments?.subtitle ?? 'Нет',
                  paddingBottom: 32,
                ),
                UnitAndTag(
                  product: product,
                ),
                AdditionalInfo(info: product?.info),
                imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: 160,
                        height: 160,
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }
}
