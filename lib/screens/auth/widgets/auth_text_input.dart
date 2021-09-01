import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AuthTextInput extends StatelessWidget {
  const AuthTextInput(
      {Key? key,
      required this.controller,
      required this.lableText,
      required this.keyboardType,
      this.obscure = false,
      this.validator,
      this.textCapitalization = TextCapitalization.none})
      : super(key: key);

  final TextEditingController controller;
  final String lableText;
  final TextInputType keyboardType;
  final bool obscure;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeVisibleController>(
        create: (_) => ChangeVisibleController(obscure),
        builder: (context, child) {
          final visible = context.watch<ChangeVisibleController>().obscure;
          return TextFormField(
            obscureText: visible,
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            style: txtMedium(16),
            decoration: InputDecoration(
                hintText: lableText,
                hintStyle: txtRegular(16),
                filled: true,
                fillColor: secondaryColor.withOpacity(0.5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                suffixIcon: obscure
                    ? visible
                        ? GestureDetector(
                            onTap: () {
                              context
                                  .read<ChangeVisibleController>()
                                  .changeVisible();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(visibleIcon),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              context
                                  .read<ChangeVisibleController>()
                                  .changeVisible();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(invisibleIcon),
                            ),
                          )
                    : null),
            validator: validator == null
                ? (value) {
                    if (value!.isEmpty) {
                      return "Can not be empty!";
                    }
                  }
                : validator,
          );
        });
  }
}

class ChangeVisibleController extends ChangeNotifier {
  late bool obscure;
  ChangeVisibleController(this.obscure);

  changeVisible() {
    obscure = !obscure;
    notifyListeners();
  }
}
