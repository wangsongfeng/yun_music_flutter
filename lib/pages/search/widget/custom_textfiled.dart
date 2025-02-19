import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../utils/image_utils.dart';

class CustomTextfiled extends StatefulWidget {
  const CustomTextfiled({super.key, this.hintText, this.text, this.onSubmit});

  final String? hintText;
  final String? text;

  final Function(String)? onSubmit;

  @override
  State<CustomTextfiled> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfiled> {
  String regStr =
      "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
  TextEditingController textEditingController = TextEditingController();
  bool autoFocus = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      textEditingController = TextEditingController(text: widget.text);
    }
    Future.delayed(const Duration(milliseconds: 240), () {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 12, right: 12),
      margin: const EdgeInsets.only(right: 8, left: 0),
      constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
      decoration: BoxDecoration(
        color: AppThemes.search_bg,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 40,
        color: Colors.transparent,
        child: TextField(
          focusNode: _focusNode,
          enabled: true,
          autofocus: autoFocus,
          enableInteractiveSelection: false,
          //禁用menu
          maxLines: 1,
          decoration: InputDecoration(
              icon: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  ImageUtils.getImagePath('home_top_bar_search'),
                  color: Get.isDarkMode ? Colors.white : AppThemes.text_gray,
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: -10, right: 0, bottom: 8),
              hintText: widget.hintText ?? '发现更多精彩',
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontFamily: W.fonts.IconFonts,
                  fontWeight: FontWeight.w500)),
          keyboardType: TextInputType.multiline,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regStr))],
          textInputAction: TextInputAction.search,
          onSubmitted: (String str) {
            print(">>>>>>>>>>>>>str:$str");
            if (widget.onSubmit != null) {
              widget.onSubmit!(str);
            }
          },
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: const Color(0xFF333333),
              fontSize: 15,
              fontFamily: W.fonts.IconFonts),
          controller: textEditingController,
          textCapitalization: TextCapitalization.sentences,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
}
