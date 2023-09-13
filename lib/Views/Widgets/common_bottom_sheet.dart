import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Controllers/theme_controller.dart';

class BottomSheetExample extends StatelessWidget {
  final themeController=Get.find<ThemeController>();
  final controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient:
          LinearGradient(
              colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.9]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Search',
            style: GoogleFonts.inter(
              fontSize: 30.0,
              color: themeController.isDarkMode.isFalse
                  ? Colors.white
                  : Colors.white,
              // Adjust the font size as needed
              fontWeight: FontWeight
                  .bold, // Adjust the font weight as needed
            ),
          ),
          SizedBox(height: 10,),
          // TextField(
          //    decoration: InputDecoration(
          //      filled: true,
          //      fillColor: Colors.white,
          //      suffixIcon: Icon(Icons.search_rounded),
          //      border: OutlineInputBorder(
          //        borderRadius: BorderRadius.circular(20)
          //      ),
          //      hintText: "Search in the categories"
          //    ),
          //   autofocus: false,
          //   onChanged: (newText) {},
          // ),
          CommonTextField(
            controller: controller,
            hintText: 'Search Categories',
            // labelText: 'Categories',
            prefixIconData: Icons.search_rounded,
            textInputAction: TextInputAction.next,
            accentColor: Colors.white,
          ),
          SizedBox(height: 10,),
          RawMaterialButton(
            elevation: 0.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text(
              'Search',
              style: GoogleFonts.inter(
                fontSize: 20.0,
                color: themeController.isDarkMode.isFalse
                    ? Colors.white
                    : Colors.white,
              ),
            ),
            fillColor: const Color(0xFF9365C6),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}


class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? helperText;
  final String? labelText;
  final int? maxLines;
  final bool hasError;
  final IconData? prefixIconData;
  final IconData? passwordHideIcon;
  final IconData? passwordShowIcon;
  final TextInputAction? textInputAction;
  final Color? textColor;
  final Color? accentColor;

  const CommonTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.helperText,
    this.labelText,
    this.hasError = false,
    this.prefixIconData,
    this.passwordHideIcon,
    this.passwordShowIcon,
    this.textInputAction,
    this.textColor,
    this.maxLines = 1,
    this.accentColor,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      maxLines: !_isObscure ? widget.maxLines : 1,
      style: TextStyle(color: widget.textColor ?? Colors.black), // Set text color
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText, // Use confirmation text as label if provided, else use default label text
        labelStyle: TextStyle(color: widget.accentColor ?? Colors.black), // Set accent color
        helperText: widget.helperText,
        prefixIcon: widget.prefixIconData != null
            ? Icon(widget.prefixIconData, color: widget.accentColor ?? theme.colorScheme.primary) // Set accent color for prefix icon
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(_isObscure ? widget.passwordShowIcon ?? Icons.visibility : widget.passwordHideIcon ?? Icons.visibility_off),
          color: widget.accentColor ?? theme.colorScheme.primary,
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.disabledColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        // You can add more customization to the decoration as needed
        // For example, adding icons, labels, etc.
      ),
    );
  }
}