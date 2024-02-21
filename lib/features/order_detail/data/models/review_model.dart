import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int? rating;
  final String? content;

  const ReviewModel({
    this.rating,
    this.content,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
