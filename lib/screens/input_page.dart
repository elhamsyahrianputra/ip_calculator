import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ip_calculator/calculator.dart';
import 'package:ip_calculator/constant.dart';
import 'package:ip_calculator/component/number_input.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController node1 = TextEditingController();
  TextEditingController node2 = TextEditingController();
  TextEditingController node3 = TextEditingController();
  TextEditingController node4 = TextEditingController();

  int value = 24;
  int min = 8;
  int max = 32;

  Widget result = Container();

  // Calculator cal = Calculator(
  //   octet1: int.parse('154'),
  //   octet2: int.parse('234'),
  //   octet3: int.parse('17'),
  //   octet4: int.parse('94'),
  //   prefix: 27,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('IP CALCULATOR'),
        foregroundColor: whiteColor,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: NumberInput(controller: node1)),
                dot(),
                Expanded(child: NumberInput(controller: node2)),
                dot(),
                Expanded(child: NumberInput(controller: node3)),
                dot(),
                Expanded(child: NumberInput(controller: node4)),
                prefix(),
                Expanded(child: numberCounter()),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          Calculator cal = Calculator(
                            octet1: int.parse(node1.text),
                            octet2: int.parse(node2.text),
                            octet3: int.parse(node3.text),
                            octet4: int.parse(node4.text),
                            prefix: value,
                          );
                          result = cal.result();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text(
                      "CALCULATE",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontFamily: 'HindSiligary',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      node1.text = '';
                      node2.text = '';
                      node3.text = '';
                      node4.text = '';
                      value = 24;
                      result = Container();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: foregroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: const BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Result",
                            style: titleStyle,
                          ),
                        ),
                      ),
                      Expanded(flex: 4, child: SizedBox()),
                    ],
                  ),
                  result,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column numberCounter() {
    return Column(
      children: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {
            setState(() {
              value++;
              if (value >= max) {
                value = max;
              }
            });
          },
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_drop_up,
            size: inputCounterSize,
            color: inputCounterColor,
          ),
        ),
        NumberInput(
          controller: TextEditingController(text: value.toString()),
          max: 32,
          min: 8,
          enabled: false,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              value--;
              if (value <= min) {
                value = min;
              }
            });
          },
          splashRadius: 24,
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.arrow_drop_down,
            size: inputCounterSize,
            color: inputCounterColor,
          ),
        ),
      ],
    );
  }

  Text dot() {
    return Text(".", style: dotStyle);
  }

  Text prefix() {
    return Text("/", style: prefixStyle);
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
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
