import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final String? value;
  final bool isEnable;
  final Function(String)? callback;

  const InputField({
    required this.title,
    required this.hint,
    this.value,
    this.isEnable = true,
    this.callback,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.value != null ? widget.value! : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle.copyWith(color: const Color(0xff3C3C3C)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: widget.title == "Phone" ? TextInputType.phone : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            widget.callback!(_controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          enabled: widget.isEnable,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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