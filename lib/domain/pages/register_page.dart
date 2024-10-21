import 'package:first_one/ui/button_stile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    String phoneNumber = _phoneController.text.trim().replaceAll(' ', '');

    if (phoneNumber.isEmpty || phoneNumber.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Пожалуйста, введите корректный номер телефона')),
      );
      return;
    }

    phoneNumber = '998$phoneNumber';

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    print('$phoneNumber');
    try {
      final response = await http.post(
        Uri.parse('https://api.sabzi.uz/api/v1/signup/'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: json.encode({
          "phone": phoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final String token = responseData['token']['access'];

        Navigator.pushNamed(
          context,
          '/otp',
          arguments: {
            'phone': phoneNumber,
            'token': token,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Регистрация'),
          backgroundColor: Color.fromRGBO(255, 127, 30, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
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
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    label: Text(
                      '+998 ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    hintText: '-- --- -- --',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text('Зарегистрироваться'),
                    style: ButtonStyles.orangeButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
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
