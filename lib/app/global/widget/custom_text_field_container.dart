import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomTextFieldContainer extends StatefulWidget {
  final IconData? prefixIcon;
  final bool? pwd;
  final bool? email;
  final bool? newPwd;
  final FocusNode? focus;
  final IconData? sufixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? hintText;
  final String? validatorText;

  const CustomTextFieldContainer({
    super.key,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.hintText,
    this.controller,
    this.validatorText,
    this.sufixIcon,
    this.pwd,
    this.email,
    this.newPwd,
    this.focus,
  });

  @override
  State<CustomTextFieldContainer> createState() =>
      _CustomTextFieldContainerState();
}

class _CustomTextFieldContainerState extends State<CustomTextFieldContainer> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        focusNode: widget.focus,
        controller: widget.controller,
        obscureText: widget.pwd == true ? !visible : visible,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validatorText;
          }

          if (widget.email == true) {
            if (!value.contains('@')) {
              return 'O email deve conter "@"';
            }
          }

          if (widget.pwd == true) {
            if (value.length < 6) {
              return 'A senha deve ter no mínimo 6 dígitos';
            }
          }

          if (widget.newPwd == true && widget.pwd == true) {
            if (value != widget.controller!.text) {
              return 'A senha e a confirmação devem ser iguais';
            }
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon, color: Colors.white),
          suffixIcon: widget.pwd == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  icon: Icon(
                    !visible ? MdiIcons.eyeOff : MdiIcons.eye,
                    color: Theme.of(context).colorScheme.primary,
                  ))
              : null,
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          hintStyle: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
