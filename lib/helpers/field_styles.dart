import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// text field styling..
class KLTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const KLTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    TextStyle kTextStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: kTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        ),
        validator: validator,
      ),
    );
  }
}

// text styling..
class KLText extends StatefulWidget {
  final String sText;
  final double textSize;
  final Color textColor;
  final int textBold;
  const KLText({
    super.key,
    required this.sText,
    required this.textSize,
    required this.textColor,
    required this.textBold,
  });

  @override
  State<KLText> createState() => _KLTextState();
}

class _KLTextState extends State<KLText> {
  FontWeight textFontWeight() {
    switch (widget.textBold) {
      case 1:
        return FontWeight.w100;
      case 2:
        return FontWeight.w200;
      case 3:
        return FontWeight.w300;
      case 4:
        return FontWeight.w400;
      case 5:
        return FontWeight.w500;
      case 6:
        return FontWeight.w700;
      default:
        return FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = textFontWeight();

    TextStyle kTextStyle = GoogleFonts.poppins(
      fontSize: widget.textSize,
      color: widget.textColor,
      fontWeight: fontWeight,
    );

    return Text(
      widget.sText,
      style: kTextStyle,
    );
  }
}


