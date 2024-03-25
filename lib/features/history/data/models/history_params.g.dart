// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryParams _$HistoryParamsFromJson(Map<String, dynamic> json) =>
    HistoryParams(
      page: json['page'] as int,
      size: json['size'] as int,
      key: json['key'] as String,
    );

Map<String, dynamic> _$HistoryParamsToJson(HistoryParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'key': instance.key,
    };
