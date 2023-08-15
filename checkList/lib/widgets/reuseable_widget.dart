
import 'package:flutter/material.dart';
//Factory Method Pattern
abstract class TextFieldFactory {
  TextFormField createTextField(String text, IconData icon, bool isPasswordType,
      TextEditingController controller);
}
class ReusableTextFieldFactory implements TextFieldFactory {
  @override
  TextFormField createTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
    return TextFormField(
        keyboardType: isPasswordType
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        controller: controller,
        obscureText: isPasswordType,
        enableSuggestions: !isPasswordType,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),
          labelText: text,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),

        ),
        autocorrect: !isPasswordType,
        cursorColor: Colors.white,
      );
    }
  }


//for login sign up button
Container signInSignUpButton(BuildContext context, bool isLogin, Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
  height: 50,
  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)) {
            return Colors.purpleAccent;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        )
      ),
      child: Text(
        isLogin ? 'LOG IN':'REGISTER',
        style: const TextStyle(
          color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 17
        ),
      ),
    ),
  );
}






