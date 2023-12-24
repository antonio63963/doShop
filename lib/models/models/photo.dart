import 'dart:convert';

const String tablePhotos = 'photos';

class PhotoFields {
  static const String id = 'id';
  static const String photo = 'photo';
  static const String productId = 'productId';
  static const String categoryId = 'categoryId';
}

class Photo {
  final int? id;
  final String photo;
  final int productId;
  final int categoryId;

  Photo({
    this.id,
    required this.photo,
    required this.productId,
    required this.categoryId,
  });

  static Photo fromJSON(Map<String, Object?> json) {
    return Photo(
      id: json[PhotoFields.id] as int,
      photo: json[PhotoFields.photo] as String,
      productId: json[PhotoFields.productId] as int,
      categoryId: json[PhotoFields.categoryId] as int,
    );
  }

  Map<String, Object?> toJSON() => {
        PhotoFields.categoryId: categoryId,
        PhotoFields.photo: photo,
        PhotoFields.productId: productId,
      };

  Photo copy({
    int? id,
    int? categoryId,
    String? photo,
    int? productId,
  }) =>
      Photo(
        id: id ?? this.id,
        photo: photo ?? this.photo,
        productId: productId ?? this.productId,
        categoryId: categoryId ?? this.categoryId,
      );
}
