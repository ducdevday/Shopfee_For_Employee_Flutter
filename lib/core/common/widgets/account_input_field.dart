import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';

class AccountInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final bool isEnable;
  final bool useFocus;
  final TextEditingController controller;

  const AccountInputField(
      {super.key,
      required this.title,
      required this.hint,
      required this.validateField,
      this.isEnable = true,
      this.useFocus = true,
      required this.controller});

  @override
  State<AccountInputField> createState() => _AccountInputFieldState();
}

class _AccountInputFieldState extends State<AccountInputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  void initState() {
    super.initState();
    if (widget.useFocus) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          setState(() {
            errorText = widget.validateField(widget.controller.text);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle
                .copyWith(color: const Color(0xff3C3C3C)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: widget.isEnable,
          validator: (value) {
            return widget.validateField(value!);
          },
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            errorText: errorText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder: AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            disabledBorder: AppStyle.outlineInputBorderDefault,
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
