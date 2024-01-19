const String tableUserTemplates = 'userTemplates';

class UserTemplateFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String img = 'img';
  static const String productsIds = 'productsIds';
}

class UserTemplate {
  final int? id;
  final String title;
  final String? subtitle;
  final String? img;
  final String productsIds;

  UserTemplate({
    this.id,
    required this.title,
    this.subtitle,
    this.img,
    required this.productsIds,
  });

  static UserTemplate fromJSON(Map<String, Object?> json) {
    return UserTemplate(
      id: json[UserTemplateFields.id] as int,
      title: json[UserTemplateFields.title] as String,
      subtitle: json[UserTemplateFields.subtitle] != null
          ? json[UserTemplateFields.subtitle] as String
          : null,
      img: json[UserTemplateFields.img] as String,
      productsIds: json[UserTemplateFields.productsIds] as String,
      // json[UserTemplateFields.productsIds] != null &&
      //         (json[UserTemplateFields.productsIds] as String).isNotEmpty
      //     ? (json[UserTemplateFields.productsIds] as String).split(',') as List<int>
      //     : [],
    );
  }

  Map<String, Object?> toJSON() => {
        UserTemplateFields.title: title,
        UserTemplateFields.subtitle: subtitle,
        UserTemplateFields.img: img,
        UserTemplateFields.productsIds: productsIds,
      };

  UserTemplate copy({
    int? id,
    String? title,
    String? img,
    String? productsIds,
  }) =>
      UserTemplate(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle,
        img: img ?? this.img,
        productsIds: productsIds ?? this.productsIds,
      );

  bool isChanged(UserTemplate uTemp) =>
      title != uTemp.title ||
      img != uTemp.img ||
      productsIds != uTemp.productsIds;

  @override
  String toString() {
    super.toString();
    return ''' 
      id: $id,
      title: $title,
      subtitle: $subtitle,
      img: $img,
      productsIds: $productsIds,
    ''';
  }

  static bool intToBool(int value) => value == 0 ? false : true;
}
