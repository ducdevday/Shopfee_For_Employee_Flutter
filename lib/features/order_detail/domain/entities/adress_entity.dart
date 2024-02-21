import 'package:shopfeeforemployee/features/order_detail/data/models/address_model.dart';

class AddressEntity {
  final String? details;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;

  AddressEntity(
      {required this.details,
      required this.note,
      required this.recipientName,
      required this.phoneNumber});

  factory AddressEntity.fromModel(AddressModel model) {
    return AddressEntity(
        details: model.details,
        note: model.note,
        recipientName: model.recipientName,
        phoneNumber: model.phoneNumber);
  }
}
