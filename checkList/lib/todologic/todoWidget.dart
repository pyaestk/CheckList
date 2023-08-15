
//for todos dialog
import 'package:flutter/material.dart';
import '../utils/colors.dart';

//Decorator design pattern
// Defining the Component Interface
abstract class TitleDescComponent {
  Widget buildTitleDescEtc(
      bool isTitle,
      String labelText,
      ValueChanged<String> onChanged,
      String initialValue,
      );
}

//Implementing the Concrete Component
class TodoFormWidget extends StatelessWidget implements TitleDescComponent {
  final String title, description, shop, price;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedShop;
  final ValueChanged<String> onChangedPrice;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.shop = '',
    this.price = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedShop,
    required this.onChangedPrice,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitleDescEtc(true, 'Title', onChangedTitle, title),
          SizedBox(
            height: 10,
          ),
          buildTitleDescEtc(false, 'Price', onChangedPrice, price),
          SizedBox(
            height: 10,
          ),
          buildTitleDescEtc(false, 'Shop', onChangedShop, shop),
          SizedBox(
            height: 20,
          ),
          buildTitleDescEtc(false, 'Description', onChangedDescription, description),
          SizedBox(
            height: 20,
          ),
          buildButton(),
        ],
      ),
    );
  }

  @override
  Widget buildTitleDescEtc(
      bool isTitle,
      String labelText,
      ValueChanged<String> onChanged,
      String initialValue,
      ) =>
      TextFormField(
        maxLines: labelText == 'Price' || labelText == "Title" ? 1 : 2,
        initialValue: initialValue,
        onChanged: onChanged,
        validator: isTitle
            ? (labelText) {
          if (labelText!.isEmpty) {
            return 'title cannot be empty';
          }
          return null;
        }
            : null,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          labelText: labelText,
          floatingLabelStyle: TextStyle(color: Colors.purple),
        ),
      );

  Widget buildButton() => Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          hexStringToColor("B267EE"),
          hexStringToColor("FF84BA"),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: onSavedTodo,
      child: Text(
        'Save',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}

// Creating the Decorator
class PaddingDecorator implements TitleDescComponent {
  final TitleDescComponent component;
  final double padding;

  PaddingDecorator(this.component, this.padding);

  @override
  Widget buildTitleDescEtc(
      bool isTitle,
      String labelText,
      ValueChanged<String> onChanged,
      String initialValue,
      ) {
    final widget = component.buildTitleDescEtc(
      isTitle,
      labelText,
      onChanged,
      initialValue,
    );
    return Padding(
      padding: EdgeInsets.all(padding),
      child: widget,
    );
  }
}


