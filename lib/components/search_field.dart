import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
    required this.onPressed,
    required this.hintText,
    this.enable = true,
  }) : super(key: key);

  final Function onPressed;
  final String hintText;
  final bool enable;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      maxWidth: 1300,
      minWidth: 1300,
      breakpoints: const [
        ResponsiveBreakpoint.resize(350, name: MOBILE),
        ResponsiveBreakpoint.resize(600, name: TABLET),
        ResponsiveBreakpoint.resize(901, name: DESKTOP),
      ],
      child: Container(
        height: 50,
        width: 630,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Observer(
          builder: (context) => Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  enabled: enable,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(37, 66, 43, 1),
                  ),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(37, 66, 43, 1),
                      ),
                    ),
                    isDense: true,
                    //filled: true,
                    contentPadding: EdgeInsets.zero,
                    //fillColor: const Color.fromRGBO(52, 61, 67, 1),
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(37, 66, 43, 1),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        'assets/icons/icon_search.svg',
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      color: const Color.fromRGBO(37, 66, 43, 1),
                      onPressed: textEditingController.clear,
                    ),
                  ),
                  maxLines: 1,
                  cursorColor: const Color.fromRGBO(37, 66, 43, 1),
                  onSubmitted: (value) {
                    onPressed(textEditingController.value.text);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: enable ? () => onPressed(textEditingController.value.text) : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(105, 50),
                  padding: EdgeInsets.zero,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: const Color.fromRGBO(248, 120, 2, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('PESQUISAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
