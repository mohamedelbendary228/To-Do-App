//import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart';
//import 'package:todoapp/auth/auth_screen.dart';
//import 'package:todoapp/auth_services/auth.dart';
//import 'package:todoapp/widgets/validators.dart';
//
//
//class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
//  final Auth auth;
//  String email;
//  String password;
//  EmailSignInFormType formType;
//  bool isLoading;
//  bool submitted;
//
//  EmailSignInChangeModel({
//    @required this.auth,
//    this.email = '',
//    this.password = '',
//    this.formType = EmailSignInFormType.signIn,
//    this.isLoading = false,
//    this.submitted = false,
//  });
//
//
//
//  String get primaryText {
//    return formType == EmailSignInFormType.signIn
//        ? 'Sign in'
//        : 'Register';
//  }
//
//  String get secondaryText {
//    return formType == EmailSignInFormType.signIn
//        ? "Don't have an account? Register"
//        : 'Have an account? Sign in';
//  }
//
//  String get svgPictureType {
//    return formType == EmailSignInFormType.signIn
//        ? 'assets/icons/signup.svg'
//        : 'assets/icons/login.svg';
//  }
//
//  String get textFormType {
//    return formType == EmailSignInFormType.signIn ? 'Sign in' : 'Sign up';
//  }
//
//
//
//
//  bool get canSubmit {
//    return emailValidator.isValid(email) &&
//        passwordValidator.isValid(password) &&
//        !isLoading;
//  }
//
//  String get showPasswordErrorText {
//    bool showErrorText = submitted && !passwordValidator.isValid(password);
//    return showErrorText ? invalidPasswordErrorText : null;
//  }
//
//  String get showEmailErrorText {
//    bool showErrorText = submitted && !emailValidator.isValid(email);
//    return showErrorText ? invalidEmailErrorText : null;
//  }
//
//  Future<void> submit() async {
//    updateWith(submitted: true, isLoading: true);
//    try {
//      if (formType == EmailSignInFormType.signIn) {
//        await auth.signInWithEmailAndPassword(email, password);
//      } else {
//        await auth.createUserWithEmailAndPassword(
//            email, password);
//      }
//    } catch (e) {
//      updateWith(isLoading: false);
//      rethrow;
//    }
//  }
//
//  void toggleFormType() {
//    final formType = this.formType == EmailSignInFormType.signIn
//        ? EmailSignInFormType.register
//        : EmailSignInFormType.signIn;
//    updateWith(
//      email: '',
//      password: '',
//      formType: formType,
//      isLoading: false,
//      submitted: false,
//    );
//  }
//
//  void updateEmail(String email) => updateWith(email: email);
//
//  void updatePassword(String password) => updateWith(password: password);
//
//
//  void updateWith({
//    String email,
//    String password,
//    EmailSignInFormType formType,
//    bool isLoading,
//    bool submitted,
//  }) {
//    this.email = email ?? this.email;
//    this.password = password ?? this.password;
//    this.formType = formType ?? this.formType;
//    this.isLoading = isLoading ?? this.isLoading;
//    this.submitted = submitted ?? this.submitted;
//
//    notifyListeners();
//  }
//}
