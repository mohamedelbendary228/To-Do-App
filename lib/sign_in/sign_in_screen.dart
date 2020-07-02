import 'file:///C:/Users/moham/AndroidStudioProjects/auth_mab_form/lib/widgest/text_field_container.dart';
import 'file:///C:/Users/moham/AndroidStudioProjects/auth_mab_form/lib/widgest/rounded_button.dart';
import 'package:authmabform/auth_services/auth.dart';
import 'package:authmabform/widgest/or_divider.dart';
import 'package:authmabform/widgest/platform_excption_alert_dailog.dart';
import 'package:authmabform/widgest/social_sign_in_buttons.dart';
import 'package:authmabform/widgest/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class SignInScreen extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _updateState() {
    setState(() {});
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }


  Future<void> _signInWithGoogle(context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Sign in' : 'Register';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? "Don't have an account? Register"
        : 'Have an account? Sign in';
    final svgPictureType = _formType == EmailSignInFormType.signIn
        ? 'assets/icons/signup.svg'
        : 'assets/icons/login.svg';
    final textFormType =
        _formType == EmailSignInFormType.signIn ? 'Sign in' : 'Sign up';

    bool showEmailErrorText =
        _submitted && !widget.emailValidator.isValid(_email);
    bool showPasswordErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: mediaQuery.height,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/signup_top.png',
              width: mediaQuery.width * 0.35,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        textFormType,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                SizedBox(height: mediaQuery.height * 0.02),
                SvgPicture.asset(
                  svgPictureType,
                  height: mediaQuery.height * 0.35,
                ),
                SizedBox(height: mediaQuery.height * 0.01),
                TextFieldContainer(
                  child: TextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: _emailEditingComplete,
                    onChanged: (email) => _updateState(),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'test@test.com',
                      errorText: showEmailErrorText
                          ? widget.invalidEmailErrorText
                          : null,
                      enabled: _isLoading == false,
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).accentColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _submit,
                    onChanged: (password) => _updateState(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: showPasswordErrorText
                          ? widget.invalidPasswordErrorText
                          : null,
                      enabled: _isLoading == false,
                      icon: Icon(
                        Icons.lock,
                        color: Theme.of(context).accentColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Theme.of(context).accentColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                RoundedButton(
                  text: primaryText,
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: _submit,
                ),
                FlatButton(
                  child: Text(
                    secondaryText,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: !_isLoading ? _toggleFormType : null,
                ),
                OrDivider(),
                SocialSignInIcons(
                  image: 'assets/icons/google-plus.svg',
                  onTap: () => _signInWithGoogle(context),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
