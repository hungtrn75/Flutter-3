import 'package:flutter/material.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_train_3/constant/patterns.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FormLogin(),
      ),
    );
  }
}

enum InputType { Email, Password }

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _isFormLogin = true;

  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed(RouteName.homePage);
  }

  void _onSubmit() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    if (_isFormLogin) {
      Provider.of<Auth>(context, listen: false).signIn(
        _emailController.text,
        _passwordController.text,
        (String content, {Color backgroundColor: Colors.redAccent}) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(content),
              backgroundColor: backgroundColor,
            ),
          );
        },
        navigateToHome,
      );
    } else {
      Provider.of<Auth>(context, listen: false).signUp(
        _emailController.text,
        _passwordController.text,
        (String content, {Color backgroundColor: Colors.redAccent}) {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(content),
              backgroundColor: backgroundColor,
            ),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<Auth>(context).isLoading;
    return Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(
              'https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png',
              height: 100,
              scale: 0.9,
            ),
          ),
          Text(
            'Email',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          FormInput(
            type: InputType.Email,
            controller: _emailController,
            onFieldSubmitted: (_) {
              _passwordFocusNode.requestFocus();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Password',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          FormInput(
            type: InputType.Password,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            onFieldSubmitted: (_) {
              _onSubmit();
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: 45,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Colors.orange[400],
              onPressed: isLoading ? null : _onSubmit,
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : Text(
                      _isFormLogin ? 'LOGIN' : 'SIGNUP',
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                    ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            child: Text(_isFormLogin
                ? 'You don\'t have an account, Sign up?'
                : 'You have already an account, Press to login?'),
            onTap: () {
              setState(() {
                _isFormLogin = !_isFormLogin;
              });
            },
          ),
        ],
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final InputType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  const FormInput({
    Key key,
    @required this.type,
    @required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPasswordField = type == InputType.Password;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPasswordField,
        textInputAction:
            isPasswordField ? TextInputAction.done : TextInputAction.next,
        keyboardType: isPasswordField
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        validator: (value) {
          if (!isPasswordField) {
            if (value.isEmpty) {
              return 'Email is required';
            }
            if (!Patterns.validateEmail.hasMatch(value)) {
              return 'Please enter a valid email';
            }
          } else {
            if (value.isEmpty) {
              return 'Password is required';
            }
            if (!Patterns.validPassword.hasMatch(value)) {
              return 'Minimum eight characters, at least one letter and one number';
            }
          }

          return null;
        },
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          prefixIcon: Icon(
            isPasswordField ? Icons.lock_outline : Icons.email,
            color: Colors.orange,
          ),
          hintText:
              isPasswordField ? 'Enter your password' : 'Enter your email',
          fillColor: Colors.grey[100],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
