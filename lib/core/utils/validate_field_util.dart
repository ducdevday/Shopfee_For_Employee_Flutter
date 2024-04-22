
import 'package:shopfeeforemployee/core/utils/format_util.dart';

class ValidateFieldUtil {
  static bool validateAccount(String account) {
    if (account.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateName(String name) {
    final RegExp nameRegExp = RegExp(r'^(?!.*\s{5,})(?!.*[^a-zA-Z\sàáảãạăắằẳẵặâấầẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵđÀÁẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÙÚỦŨỤƯỨỪỬỮỰỲÝỶỸỴĐ]).{2,30}$');
    if (!nameRegExp.hasMatch(name)) {
      return false;
    }
    return true;
  }


  static bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }

  static bool validatePhone(String phone) {
    phone = FormatUtil.formatOriginalPhone(phone);
    if (phone.length != 10) {
      return false;
    }
    return true;
  }

  static bool validateAddress(String address) {
    if (address.isEmpty) {
      return false;
    }
    return true;
  }
}
