import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends ReviewEntity{
  ReviewModel({required super.rating, required super.content});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}