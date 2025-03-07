import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:brasil_fields/brasil_fields.dart';

class CustomTextFieldContainer extends StatefulWidget {
  final IconData? prefixIcon;
  final bool? pwd;
  final bool? email;
  final bool? newPwd;
  final bool? phone; // Campo de telefone
  final bool? cpf; // Campo de CPF
  final FocusNode? focus;
  final IconData? sufixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? hintText;
  final String? validatorText;
  final bool? desableDecoration;
  final ValueChanged<String>? onChanged;

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
    this.phone,
    this.cpf,
    this.focus,
    this.desableDecoration,
    this.onChanged,
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
      decoration: widget.desableDecoration == true
          ? null
          : BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
      child: Row(
        children: [
          if (widget.phone == true)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/brasil.png',
                    width: 24,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '+55',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else if (widget.cpf == true)
            Icon(MdiIcons.cardAccountDetails, color: Colors.white)
          else
            Icon(widget.prefixIcon, color: Colors.white),
          Expanded(
            child: TextFormField(
              focusNode: widget.focus,
              controller: widget.controller,
              obscureText: widget.pwd == true ? !visible : visible,
              keyboardType: widget.phone == true
                  ? TextInputType.phone
                  : widget.cpf == true
                      ? TextInputType.number
                      : widget.keyboardType,
              inputFormatters: widget.phone == true
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ]
                  : widget.cpf == true
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ]
                      : widget.inputFormatters,
              onChanged: widget.onChanged,
              validator: (value) {
                if (value!.isEmpty) {
                  return widget.validatorText;
                }

                if (widget.email == true && !value.contains('@')) {
                  return 'O email deve conter "@"';
                }

                if (widget.pwd == true && value.length < 6) {
                  return 'A senha deve ter no mínimo 6 dígitos';
                }

                if (widget.newPwd == true && widget.pwd == true) {
                  if (value != widget.controller!.text) {
                    return 'A senha e a confirmação devem ser iguais';
                  }
                }

                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border:
                    widget.desableDecoration == true ? null : InputBorder.none,
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
                        ),
                      )
                    : null,
                labelText: widget.hintText,
                labelStyle: Theme.of(context).textTheme.titleSmall,
                hintStyle: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
