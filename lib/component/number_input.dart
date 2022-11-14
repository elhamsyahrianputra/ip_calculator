import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ip_calculator/constant.dart';

class NumberInput extends StatelessWidget {
  TextEditingController? controller;
  bool enabled;
  double min;
  double max;

  NumberInput({
    this.controller,
    this.enabled = true,
    this.min = 0,
    this.max = 255,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: inputPadding,
      decoration: const BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        onTap: () => controller?.selection =
            TextSelection(baseOffset: 0, extentOffset: controller!.text.length),
        controller: controller,
        enabled: enabled,
        maxLength: 3,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: cursorColor,
        style: inputTextStyle,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          NumericalRangeFormatter(min: min, max: max)
        ],
      ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toStringAsFixed(0));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
