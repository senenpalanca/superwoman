import 'package:flutter/material.dart';

//Personalized text input
class TextInput extends StatefulWidget {
  TextInput(this.hint, this.controller,
      {Key? key,
      this.icon,
      this.inputType,
      this.inputAction,
      this.regexp,
      this.errorMsg})
      : super(key: key);

  final IconData? icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController controller;
  final RegExp? regexp;
  final String? errorMsg;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isInvalid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          //height: isInvalid ? size.height * 0.096 : null,
          //width: size.width * 0.8,
          decoration: BoxDecoration(
            //color: Colors.grey[300].withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: TextFormField(
              validator: (value) {
                if(value != null){
                  bool cond = widget.regexp!.hasMatch(value);
                  if(!cond){
                    return widget.errorMsg;
                  }
                }
                return null;
              },
              controller: widget.controller,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.only(left: 20),
                filled: true,
                fillColor: Colors.grey[300]?.withOpacity(0.5),
                // isDense: true,
                border: InputBorder.none,

                prefixIcon: widget.icon == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              keyboardType: widget.inputType,
              textInputAction: widget.inputAction,
            ),
          ),
        ));
  }
}
