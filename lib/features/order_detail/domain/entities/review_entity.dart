import 'package:shopfeeforemployee/features/order_detail/data/models/review_model.dart';

class ReviewEntity {
  final int? rating;
  final String? content;

  ReviewEntity({required this.rating, required this.content});

  factory ReviewEntity.fromModel(ReviewModel model) {
    return ReviewEntity(rating: model.rating, content: model.content);
  }
}
