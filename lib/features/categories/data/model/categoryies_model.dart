import '/core/base_classes/base_list_response.dart';
import '../../domain/entity/category_entity.dart';

class CategoriesRespModel extends BaseListResponse {
  // final int? currentPage;
  // final int? totalPages;
  // final int? numberOfItems;
  // final String? time;

  const CategoriesRespModel({
    super.message,
    super.status,
    super.data,

    //   super.currentPage,
    // super.totalPages,
    // super.numberOfItems,
  });

  factory CategoriesRespModel.fromJson(Map<String, dynamic> json) =>
      CategoriesRespModel(
        message: json["message"],
        status: json["status"],

        data: json["result"] == null
            ? []
            : List<CategoryModel>.from(
                json["result"]!.map((x) => CategoryModel.fromJson(x))),
        // currentPage: json["current_page"],
        // totalPages: json["total_pages"],
        // numberOfItems: json["number_of_items"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,

        "result": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        // "current_page": currentPage,
        // "total_pages": totalPages,
        // "number_of_items": numberOfItems,
      };
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.image,
    required super.icon,
  });

  // Map JSON to `CategoryModel`
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      image: json['image'],
      icon: json['icon'],
    );
  }

  // Map `CategoryModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'image': image,
      'icon': icon,
    };
  }
}

