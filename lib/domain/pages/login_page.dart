import 'package:first_one/ui/button_stile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  // Изменено на StatefulWidget
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration:const BoxDecoration(
                image:  DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:const BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50.0,
                        height: 5.0,
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                     const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _buildPhoneField(),
                      SizedBox(height: 20.0),
                      _buildPasswordField(), 
                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Parolni unutdim',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: Text(
                          'Ro‘yxatdan o‘tish',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyles.orangeButtonStyle,
                          child: Text(
                            'Kirish',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      child: TextField(
        focusNode: _phoneFocusNode,
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
        onTap: () {},
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(9),
          PhoneNumberFormatter(),
        ],
        decoration: InputDecoration(
          prefix: Text(
            '+998 ',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          prefixIcon: Icon(Icons.phone),
          label: Text(
            '+998 ',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          alignLabelWithHint: true,
          hintStyle: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          hintText: '-- --- -- --',
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      focusNode: _passwordFocusNode,
      obscureText: !_isPasswordVisible, 
      decoration: InputDecoration(
        hintText: 'Parol',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility
                : Icons
                    .visibility_off, 
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; 
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    newText = newText.replaceAll(' ', '');

    String formattedText = '';
    if (newText.length > 0) {
      formattedText += newText.substring(0, newText.length.clamp(0, 2));
    }
    if (newText.length > 2) {
      formattedText += ' ' + newText.substring(2, newText.length.clamp(2, 5));
    }
    if (newText.length > 5) {
      formattedText += ' ' + newText.substring(5, newText.length.clamp(5, 7));
    }
    if (newText.length > 7) {
      formattedText += ' ' + newText.substring(7, newText.length.clamp(7, 9));
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
