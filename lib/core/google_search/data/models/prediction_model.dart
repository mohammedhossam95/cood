import '../../domain/entities/awesome_place_entity.dart';
import 'awesome_place_model.dart';

class PredictionModel extends PredictionEntity {
  PredictionModel({
    super.latitude,
    super.longitude,
    super.description,
    List<MatchedSubstring>? super.matchedSubstrings,
    super.placeId,
    super.reference,
    StructuredFormatting? super.structuredFormatting,
    List<Term>? super.terms,
    super.types,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        description: json["description"],
        matchedSubstrings: json["matched_substrings"] == null
            ? []
            : List<MatchedSubstring>.from(json["matched_substrings"]!
                .map((x) => MatchedSubstring.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting: json["structured_formatting"] == null
            ? null
            : StructuredFormatting.fromJson(json["structured_formatting"]),
        terms: json["terms"] == null
            ? []
            : List<Term>.from(json["terms"]!.map((x) => Term.fromJson(x))),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );
}
