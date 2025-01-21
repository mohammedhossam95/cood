import 'dart:convert';

import '../../data/models/prediction_model.dart';
import '../../domain/entities/awesome_place_entity.dart';
import '../../domain/entities/param_search_entity.dart';

AwesomePlacesSearchModel awesomePlacesModelFromJson(String str) =>
    AwesomePlacesSearchModel.fromJson(json.decode(str));

class AwesomePlacesSearchModel extends AwesomePlacesSearchEntity {
  final List<PredictionModel>? predictionsModel;
  AwesomePlacesSearchModel({
    this.predictionsModel,
    super.status,
  }) : super(predictions: predictionsModel);

  factory AwesomePlacesSearchModel.fromJson(Map<String, dynamic> json) =>
      AwesomePlacesSearchModel(
        predictionsModel: json["predictions"] == null
            ? []
            : List<PredictionModel>.from(
                json["predictions"]!.map((x) => PredictionModel.fromJson(x))),
        status: json["status"],
      );
}

class MatchedSubstring extends MatchedSubstringEntity {
  MatchedSubstring({
    super.length,
    super.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );
}

class StructuredFormatting extends StructuredFormattingEntity {
  StructuredFormatting({
    super.mainText,
    List<MatchedSubstring>? super.mainTextMatchedSubstrings,
    super.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        mainTextMatchedSubstrings: json["main_text_matched_substrings"] == null
            ? []
            : List<MatchedSubstring>.from(json["main_text_matched_substrings"]!
                .map((x) => MatchedSubstring.fromJson(x))),
        secondaryText: json["secondary_text"],
      );
}

class Term extends TermEntity {
  Term({
    super.offset,
    super.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        offset: json["offset"],
        value: json["value"],
      );
}

class ParamSearchModel extends ParamSearchEntity {
  ParamSearchModel({required super.value, required super.key});
}
