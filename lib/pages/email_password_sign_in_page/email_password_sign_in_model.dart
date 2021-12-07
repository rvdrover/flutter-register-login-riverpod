import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/email_password_sign_in_page/string_validater.dart';

import 'email_password_sign_in_string.dart';

enum EmailPasswordSignInFormType { signIn, register, forgotPassword }

class EmailAndPasswordValidators {
  final TextInputFormatter emailInputFormatter =
      ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator());

  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();

  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);

  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

class EmailPasswordSignInModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailPasswordSignInModel({
    required this.firebaseAuth,
    this.email = '',
    this.password = '',
    this.formType = EmailPasswordSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final FirebaseAuth firebaseAuth;

  String email;
  String password;
  EmailPasswordSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<bool> submit() async {
    try {
      updateWith(submitted: true);
      if (!canSubmit) {
        return false;
      }
      updateWith(isLoading: true);
      switch (formType) {
        case EmailPasswordSignInFormType.signIn:
          await firebaseAuth.signInWithCredential(
              EmailAuthProvider.credential(email: email, password: password));
          break;
        case EmailPasswordSignInFormType.register:
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          break;
        case EmailPasswordSignInFormType.forgotPassword:
          await firebaseAuth.sendPasswordResetEmail(email: email);
          updateWith(isLoading: false);
          break;
      }
      return true;
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateFormType(EmailPasswordSignInFormType formType) {
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );

  }

  void updateWith({
    String? email,
    String? password,
    EmailPasswordSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }

  String get passwordLabelText {
    if (formType == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInStrings.password8CharactersLabel;
    }

    return EmailPasswordSignInStrings.passwordLabel;

  }

  // Getters
  String get primaryButtonText {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.createAnAccount,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.sendResetLink,
    }[formType]!;
  }

  String get secondaryButtonText {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.haveAnAccount,
      EmailPasswordSignInFormType.signIn:
          EmailPasswordSignInStrings.needAnAccount,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.backToSignIn,
    }[formType]!;
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    return <EmailPasswordSignInFormType, EmailPasswordSignInFormType>{
      EmailPasswordSignInFormType.register: EmailPasswordSignInFormType.signIn,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInFormType.register,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInFormType.signIn,
    }[formType]!;
  }

  String get errorAlertTitle {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register:
          EmailPasswordSignInStrings.registrationFailed,
      EmailPasswordSignInFormType.signIn:
          EmailPasswordSignInStrings.signInFailed,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.passwordResetFailed,
    }[formType]!;
  }

  String get title {
    return <EmailPasswordSignInFormType, String>{
      EmailPasswordSignInFormType.register: EmailPasswordSignInStrings.register,
      EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
      EmailPasswordSignInFormType.forgotPassword:
          EmailPasswordSignInStrings.forgotPassword,
    }[formType]!;
  }

  bool get canSubmitEmail {
    return emailSubmitValidator.isValid(email);
  }

  bool get canSubmitPassword {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  bool get canSubmit {
    final bool canSubmitFields =
        formType == EmailPasswordSignInFormType.forgotPassword
            ? canSubmitEmail
            : canSubmitEmail && canSubmitPassword;
    return canSubmitFields && !isLoading;
  }

  String? get emailErrorText {
    final bool showErrorText = submitted && !canSubmitEmail;
    final String errorText = email.isEmpty
        ? EmailPasswordSignInStrings.invalidEmailEmpty
        : EmailPasswordSignInStrings.invalidEmailErrorText;
    return showErrorText ? errorText : null;
  }

  String? get passwordErrorText {
    final bool showErrorText = submitted && !canSubmitPassword;
    final String errorText = password.isEmpty
        ? EmailPasswordSignInStrings.invalidPasswordEmpty
        : EmailPasswordSignInStrings.invalidPasswordTooShort;
    return showErrorText ? errorText : null;
  }

  @override
  String toString() {
    return 'email: $email, password: $password, formType: $formType, isLoading: $isLoading, submitted: $submitted';
  }
}

// enum EmailPasswordSignInFormType { signIn, register, forgotPassword }

// class EmailAndPasswordValidators {
//   final TextInputFormatter emailInputFormatter =
//       ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator());

//   final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();

//   final StringValidator passwordRegisterSubmitValidator =
//       MinLengthStringValidator(8);

//   final StringValidator passwordSignInSubmitValidator =
//       NonEmptyStringValidator();
// }


// class EmailAndPasswordSign {
//   EmailAndPasswordSign({
//     this.email = '',
//     this.password = '',
//     this.formType = EmailPasswordSignInFormType.signIn,
//     this.isLoading = false,
//     this.submitted = false,
//   });
//   String email;
//   String password;
//   EmailPasswordSignInFormType formType;
//   bool isLoading;
//   bool submitted;
// }


// class EmailPasswordSignInModel extends StateNotifier<EmailAndPasswordSign> {
//   EmailPasswordSignInModel():super(EmailAndPasswordSign());
//  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
//   EmailAndPasswordValidators emailAndPasswordValidators =EmailAndPasswordValidators();



//   Future<bool> submit() async {
//     try {
//       updateWith(submitted: true);
//       if (!canSubmit()) {
//         return false;
//       }
//       updateWith(isLoading: true);
//       switch (state.formType) {
//         case EmailPasswordSignInFormType.signIn:
//           await firebaseAuth.signInWithCredential(
//               EmailAuthProvider.credential(email: state.email, password: state.password));
//           break;
//         case EmailPasswordSignInFormType.register:
//           await firebaseAuth.createUserWithEmailAndPassword(
//               email: state.email, password: state.password);
//           break;
//         case EmailPasswordSignInFormType.forgotPassword:
//           await firebaseAuth.sendPasswordResetEmail(email: state.email);
//           updateWith(isLoading: false);
//           break;
//       }
//       return true;
//     } catch (e) {
//       updateWith(isLoading: false);
//       rethrow;
//     }
//   }

//   void updateEmail(String email) => updateWith(email: email);

//   void updatePassword(String password) => updateWith(password: password);

//   void updateFormType(EmailPasswordSignInFormType formType) {
//     updateWith(
//       email: '',
//       password: '',
//       formType: formType,
//       isLoading: false,
//       submitted: false,
//     );
//   }

//   void updateWith({
//     String? email,
//     String? password,
//     EmailPasswordSignInFormType? formType,
//     bool? isLoading,
//     bool? submitted,
//   }) {
//     state.email = email ?? state.email;
//     state.password = password ?? state.password;
//     state.formType = formType ?? state.formType;
//     state.isLoading = isLoading ?? state.isLoading;
//     state.submitted = submitted ?? state.submitted;
//   }

//   String passwordLabelText() {
//     if (state.formType == EmailPasswordSignInFormType.register) {
//       return EmailPasswordSignInStrings.password8CharactersLabel;
//     }

//     return EmailPasswordSignInStrings.passwordLabel;
//   }

//   // Getters
//   String primaryButtonText() {
//     return <EmailPasswordSignInFormType, String>{
//       EmailPasswordSignInFormType.register:
//           EmailPasswordSignInStrings.createAnAccount,
//       EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
//       EmailPasswordSignInFormType.forgotPassword:
//           EmailPasswordSignInStrings.sendResetLink,
//     }[state.formType]!;
//   }

//   String secondaryButtonText() {
//     return <EmailPasswordSignInFormType, String>{
//       EmailPasswordSignInFormType.register:
//           EmailPasswordSignInStrings.haveAnAccount,
//       EmailPasswordSignInFormType.signIn:
//           EmailPasswordSignInStrings.needAnAccount,
//       EmailPasswordSignInFormType.forgotPassword:
//           EmailPasswordSignInStrings.backToSignIn,
//     }[state.formType]!;
//   }

//   EmailPasswordSignInFormType  secondaryActionFormType() {
//     return <EmailPasswordSignInFormType, EmailPasswordSignInFormType>{
//       EmailPasswordSignInFormType.register: EmailPasswordSignInFormType.signIn,
//       EmailPasswordSignInFormType.signIn: EmailPasswordSignInFormType.register,
//       EmailPasswordSignInFormType.forgotPassword:
//           EmailPasswordSignInFormType.signIn,
//     }[state.formType]!;
//   }

//   String errorAlertTitle() {
//     return <EmailPasswordSignInFormType, String>{
//       EmailPasswordSignInFormType.register:
//           EmailPasswordSignInStrings.registrationFailed,
//       EmailPasswordSignInFormType.signIn:
//           EmailPasswordSignInStrings.signInFailed,
//       EmailPasswordSignInFormType.forgotPassword:
//           EmailPasswordSignInStrings.passwordResetFailed,
//     }[state.formType]!;
//   }

//   String  title (){
//     return <EmailPasswordSignInFormType, String>{
//       EmailPasswordSignInFormType.register: EmailPasswordSignInStrings.register,
//       EmailPasswordSignInFormType.signIn: EmailPasswordSignInStrings.signIn,
//       EmailPasswordSignInFormType.forgotPassword:
//           EmailPasswordSignInStrings.forgotPassword,
//     }[state.formType]!;
//   }

//   bool canSubmitEmail() {
//     return emailAndPasswordValidators.emailSubmitValidator.isValid(state.email);
//   }

//   bool canSubmitPassword() {
//     if (state.formType == EmailPasswordSignInFormType.register) {
//       return emailAndPasswordValidators.passwordRegisterSubmitValidator
//           .isValid(state.password);
//     }
//     return emailAndPasswordValidators.passwordSignInSubmitValidator
//         .isValid(state.password);
//   }

//   bool canSubmit() {
//     final bool canSubmitFields =
//         state.formType == EmailPasswordSignInFormType.forgotPassword ? canSubmitEmail() : canSubmitEmail() && canSubmitPassword();
//     return canSubmitFields && !state.isLoading;
//   }

//   String? emailErrorText (){
//     final bool showErrorText = state.submitted && !canSubmitEmail();
//     final String errorText = state.email.isEmpty
//         ? EmailPasswordSignInStrings.invalidEmailEmpty
//         : EmailPasswordSignInStrings.invalidEmailErrorText;
//     return showErrorText ? errorText : null;
//   }

//   String? passwordErrorText() {
//     final bool showErrorText = state.submitted && !canSubmitPassword();
//     final String errorText = state.password.isEmpty
//         ? EmailPasswordSignInStrings.invalidPasswordEmpty
//         : EmailPasswordSignInStrings.invalidPasswordTooShort;
//     return showErrorText ? errorText : null;
//   }

//   @override
//   String toString() {
//     return 'email: $state.email, password: $state.password, formType: $state.formType, isLoading: $state.isLoading, submitted: $state.submitted';
//   }
// }
