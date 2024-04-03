import 'package:json_annotation/json_annotation.dart';

part 'history_params.g.dart';

@JsonSerializable()
class HistoryParams {
  final int page;
  final int size;
  final String? key;

  const HistoryParams({
    required this.page,
    required this.size,
    this.key,
  });

  factory HistoryParams.fromJson(Map<String, dynamic> json) {
    return _$HistoryParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HistoryParamsToJson(this);
  }
}
