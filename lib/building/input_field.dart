import "package:flutter/material.dart";

import 'contants.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget? widget;
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  autofocus: false,
                  cursorColor: Colors.grey,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                  ),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: widget),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
