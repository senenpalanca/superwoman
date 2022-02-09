import 'package:flutter/material.dart';

//Personalized text input
class TextInput extends StatefulWidget {
  TextInput(this.hint, this.controller,
      {Key? key,
      this.icon,
      this.inputType,
      this.inputAction,
      this.regexp,
      this.errorMsg,
      this.multiLine})
      : super(key: key);

  final IconData? icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController controller;
  final RegExp? regexp;
  final String? errorMsg;
  final bool? multiLine;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isInvalid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding:const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          height:  widget.multiLine??false ? size.height * 0.096 * 2 : size.height * 0.096  ,
          child: Center(
            child: TextFormField(
              validator: (value) {
                if (value != null) {
                  bool cond = widget.regexp!.hasMatch(value);
                  if (!cond) {
                    return widget.errorMsg;
                  }
                }
                return null;
              },
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300]?.withOpacity(0.5),
                border: InputBorder.none,
                prefixIcon: widget.icon == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
                        child: Icon(
                          widget.icon,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                hintText: widget.hint,
                hintStyle:
                    TextStyle(fontSize: 18, color: Colors.grey, height: 1.5),
                errorStyle: TextStyle(fontSize: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: TextStyle(fontSize: 18, color: Colors.grey, height: 1.5),
              keyboardType: widget.multiLine??false ? TextInputType.multiline : widget.inputType,
              maxLines: widget.multiLine??false ? 3 : 1,
              textInputAction: widget.inputAction,

            ),
          ),
        ));
  }
}
