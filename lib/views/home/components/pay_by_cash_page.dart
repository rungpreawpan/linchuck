import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class PayByCashPage extends StatefulWidget {
  final double total;

  const PayByCashPage({
    super.key,
    required this.total,
  });

  @override
  State<PayByCashPage> createState() => _PayByCashPageState();
}

class _PayByCashPageState extends State<PayByCashPage> {
  String equation = '0';
  String result = '0';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(marginX2),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(212, 220, 233, 1),
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            _keyBoard(),
            const SizedBox(width: 20.0),
            _changeData(),
          ],
        ),
      ),
    );
  }

  _keyBoard() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextFontStyle(
            'เงินที่ได้รับ',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: margin),
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(
              horizontal: marginX2,
              vertical: margin,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: customBoxShadow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFontStyle(
                  result,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('9');
                },
                number: '9',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('8');
                },
                number: '8',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('7');
                },
                number: '7',
              ),
            ],
          ),
          const SizedBox(height: margin),
          Row(
            children: [
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('4');
                },
                number: '4',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('5');
                },
                number: '5',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('6');
                },
                number: '6',
              ),
            ],
          ),
          const SizedBox(height: margin),
          Row(
            children: [
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('1');
                },
                number: '1',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('2');
                },
                number: '2',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('3');
                },
                number: '3',
              ),
            ],
          ),
          const SizedBox(height: margin),
          Row(
            children: [
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('.');
                },
                number: '.',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('0');
                },
                number: '0',
              ),
              const SizedBox(width: margin),
              _keyBoardButton(
                onTap: () {
                  _keyboardPress('delete');
                },
                isDeleteButton: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _keyBoardButton({
    required Function() onTap,
    bool isDeleteButton = false,
    String? number,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade600),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: customBoxShadow,
          ),
          child: Center(
            child: isDeleteButton
                ? const Icon(Icons.backspace_outlined)
                : TextFontStyle(
                    number!,
                    size: fontSizeM,
                    weight: FontWeight.bold,
                  ),
          ),
        ),
      ),
    );
  }

  _keyboardPress(String buttonText) {
    if (buttonText == 'delete') {
      equation = equation.substring(0, equation.length - 1);
      if (equation == '') {
        equation = '0';
      }

      result = equation;
    } else {
      // กรณีพิมพ์เลขตัวแรก
      if (equation == '0') {
        if (buttonText == '.') {
          equation = '0.';
          result = equation;
        } else {
          equation = buttonText;
          result = equation;
        }
        // กรณีพิมพ์เลขที่ไม่ใช่ตัวแรก
      } else {
        if (result.contains('.')) {
          if (buttonText == '.') {
            result = result;
          } else {
            equation = equation + buttonText;
            result = equation;
          }
        } else {
          equation = equation + buttonText;
          result = equation;
        }
      }
    }

    setState(() {});
  }

  _changeData() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: marginX2),
            color: const Color.fromRGBO(30, 64, 162, 1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  children: [
                    TextFontStyle(
                      'ยอดรวม',
                      color: Colors.white,
                      size: fontSizeM,
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
                const SizedBox(width: 20.0),
                TextFontStyle(
                  widget.total.toString(),
                  color: Colors.white,
                  size: 60.0,
                  weight: FontWeight.bold,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: marginX2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFontStyle(
                  'เงินทอน',
                  size: 20.0,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  _calChange(),
                  size: 20.0,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const SizedBox(height: marginX2),
          Container(
            height: 40.0,
            padding: const EdgeInsets.symmetric(horizontal: marginX2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFontStyle(
                  'รหัสพนักงาน',
                  size: 20.0,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  '123456',
                  size: 20.0,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          _confirmPaymentButton(),
        ],
      ),
    );
  }

  _calChange() {
    double total = widget.total;
    double received = double.parse(result);
    double change = 0.0;

    change = received - total;
    return change.toString();
  }

  _confirmPaymentButton() {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(34, 164, 71, 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: const Center(
              child: TextFontStyle(
                'ยืนยันการชำระเงิน',
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: margin),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const TextFontStyle(
            'ยกเลิกออเดอร์',
            color: Colors.red,
            weight: FontWeight.bold,
            isUnderline: true,
          ),
        ),
      ],
    );
  }
}
