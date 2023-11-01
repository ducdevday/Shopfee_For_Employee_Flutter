// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      details: json['details'] as String?,
      note: json['note'] as String?,
      recipientName: json['recipientName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'details': instance.details,
      'note': instance.note,
      'recipientName': instance.recipientName,
      'phoneNumber': instance.phoneNumber,
    };
