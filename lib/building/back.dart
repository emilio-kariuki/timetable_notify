import "package:flutter/material.dart";

class Back extends StatelessWidget {
  final String imageUrl;
  final Function() function;
  const Back({Key? key, required this.imageUrl, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: GestureDetector(
        onTap: function,
        child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child:
                Image.asset(imageUrl, color: Colors.black, fit: BoxFit.cover)),
      ),
    );
  }
}
