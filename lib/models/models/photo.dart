import 'dart:typed_data';

const String tablePhotos = 'photos';

class PhotoFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String photo = 'photo';
  static const String productId = 'productId';
  static const String categoryId = 'categoryId';
}

class Photo {
  final int? id;
  final String title;
  final Uint8List photo;
  final int productId;
  final int categoryId;

  Photo({
    this.id,
    required this.title,
    required this.photo,
    required this.productId,
    required this.categoryId,
  });

  static Photo fromJSON(Map<String, Object?> json) {
    return Photo(
      id: json[PhotoFields.id] as int,
      title: json[PhotoFields.title] as String,
      photo: json[PhotoFields.photo] as Uint8List,
      productId: json[PhotoFields.productId] as int,
      categoryId: json[PhotoFields.categoryId] as int,
    );
  }
}
