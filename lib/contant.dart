
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget addHorizontalySpace(double width) {
  return SizedBox(width: width);
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Color primary = Colors.blue.shade900;

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

TextStyle bodyText12Small({required Color color, double? spacing}) {
  return TextStyle(
      fontSize: 12, height: spacing, color: color, fontWeight: FontWeight.w400);
}

TextStyle bodyText16w600({
  required Color color,
  double? spacing,
}) {
  return TextStyle(
      height: spacing, fontSize: 16, color: color, fontWeight: FontWeight.w700);
}

class CustomButton extends StatelessWidget {
  const CustomButton({required this.name, required this.onPressed});

  final String name;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height(context) * 0.05,
        width: width(context) * 0.95,
        decoration: myFillBoxDecoration(0, primary, 10),
        child: Center(
          child: Text(
            name,
            style: bodyText16w600(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

BoxDecoration myFillBoxDecoration(double width, Color color, double radius) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: width, color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius) //
        ),
  );
}

BoxDecoration shadowDecoration(double radius, double blur) {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: blur,
        ),
      ]);
}

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {required this.labelText,
      this.icon,
      this.onClick,
      this.controller,
        this.keyboardtype,
        this.length,
      this.Enable});

  String labelText;
  Icon? icon;
  bool? Enable;
  var keyboardtype;
  var length;
  TextEditingController? controller;
  VoidCallback? onClick;
  // void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.05,
      width: width(context) * 0.95,
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primary,
              ),
        ),
        child: TextFormField(
          maxLength: length,
          validator: (value) {
            if (value!.isNotEmpty) {
              return null;
            }
            return "Value Cannot be Empty";
          },
          enabled: Enable,
          onTap: onClick,
          controller: controller,
          // onChanged:(String){ onChanged},
          keyboardType: keyboardtype,
          decoration: InputDecoration(
            suffixIcon: icon,
            labelText: labelText,
            // labelStyle: bodyText14w600(color: primarhy),

            focusColor: primary,

            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.only(
              left: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton(
      {super.key,
      required this.itemList,
      this.lableText,
      TextEditingController? controller,
      this.value});
  final List<String> itemList;
  final value;
  final lableText;
  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.85,
      height: 45,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            border: InputBorder.none,
            labelStyle: bodyText12Small(color: Colors.black),
            label: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 20,
                    // width: width(context) * 0.35,
                    decoration: myFillBoxDecoration(0, Colors.white, 20),
                    child: Center(
                      child: Text(
                        widget.lableText,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            fillColor: Color.fromRGBO(241, 241, 241, 1),
            filled: true,
            contentPadding: EdgeInsets.only(left: 12, right: 4, top: 5)),
        hint: Text(
          '--Select--',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        items: widget.itemList
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
            .toList(),
        value: selectedItem,
        onChanged: (newValue) {
          setState(() {
            selectedItem = newValue!;
          });
        },
      ),
    );
  }
}
