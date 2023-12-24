import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/photo.service.dart';

import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/carousel_images.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/take_photo.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/info_row.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/menu_product.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/widgets/unit_and_tag.dart';
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

  void pickCamera(ImageSource imgSrc) async {
    ImagePicker().pickImage(source: imgSrc).then((image) {
      if (image != null &&
          _productProvider != null &&
          _productProvider?.productDetails != null) {
        saveImage(context, image, _productProvider!.productDetails!);
      }
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
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
            icon: const Icon(
              Icons.home,
              color: MyColors.primary,
            ),
          ),
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
              isScreenEmpty: product == null,
              paddingHorizontal: AppPadding.bodyHorizontal,
              onRefresh: refresh,
              widgets: [
                product != null && product.photos!.isEmpty
                    ? TakePhoto(onClick: () => pickCamera(ImageSource.camera))
                    : CarouselImages(product: product!),
                InfoRow(
                  labelText: 'Категория:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: product.catImg ?? DefaultValues.icon,
                  text:
                      '${product.categoryTitle} ${product.categorySubtitle}',
                  paddingBottom: 32,
                  paddingTop: 32,
                ),
                InfoRow(
                  labelText: 'Короткое описание:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: product.icon ?? DefaultValues.icon,
                  text: _screenArguments?.subtitle ?? 'Нет',
                  paddingBottom: 32,
                ),
                UnitAndTag(
                  product: product,
                ),
                AdditionalInfo(info: product.info),
              ],
            ),
    );
  }
}
