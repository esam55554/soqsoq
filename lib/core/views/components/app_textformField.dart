import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soqsoq/core/constants/app_colors.dart';

class AppTextformfield extends StatefulWidget {
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  String label;
  String? hint;
  bool isPwd = false;
  bool isEmail = false;
  bool isDoB = false;
  bool hidePwd = true;
  DateTime? selectedDate;
  final TextEditingController? controller;

  AppTextformfield({
    super.key,
    required this.label,
    this.hint,
    this.isPwd = false,
    this.isEmail = false,
    this.isDoB = false,
    this.hidePwd = true,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.selectedDate,
  });

  @override
  State<AppTextformfield> createState() => _AppTextformfieldState();
}

class _AppTextformfieldState extends State<AppTextformfield> {
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPwd && widget.hidePwd,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,

      decoration: InputDecoration(
        label: Text(widget.label),
        floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        //hint..Text: widget.hintt != null ? Text(widget.hint!) : null,
        suffixIcon: widget.isPwd
            ? IconButton(
                icon: Icon(
                  widget.hidePwd ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => widget.hidePwd = !widget.hidePwd),
              )
            : widget.isEmail
            ? Icon(Icons.email)
            : widget.isDoB
            ? Icon(Icons.calendar_today)
            : null,
        suffixIconColor: WidgetStateColor.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.primaryColor;
          }
          return Colors.grey;
        }),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}
