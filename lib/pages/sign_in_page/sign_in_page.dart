import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/buttons/submit_button.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_manager.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/strings.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/routing/app_router.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/spinner/spinner.dart';

// class SignInPage extends ConsumerWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final signInModel = ref.watch(signInManagerProvider);
//     ref.listen<SignInManager>(signInManagerProvider, (_, model) async {
//       if (model.error != null) {
//         await showExceptionAlertDialog(
//           context: context,
//           title: Strings.signInFailed,
//           exception: model.error,
//         );
//       }
//     });
//     return SignInPageContents(
//       signInManager: signInModel,
//       title: 'Riverpod Sign In',
//     );
//   }
// }

// class SignInPageContents extends StatelessWidget {
//   const SignInPageContents(
//       {Key? key, required this.signInManager, this.title = 'Architecture Demo'})
//       : super(key: key);
//   final SignInManager signInManager;
//   final String title;

//   static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
//   static const Key anonymousButtonKey = Key(Keys.anonymous);
//   static const Key googlesignButtonKey = Key(Keys.googleSign);
//   static const Key facebookSignButtonKey = Key(Keys.facebookSign);

//   Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
//     final navigator = Navigator.of(context);
//     await navigator.pushNamed(
//       AppRoutes.emailPasswordSignInPage,
//       arguments: () => navigator.pop(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 2.0,
//         title: Text(title),
//       ),
//       backgroundColor: Colors.grey[200],
//       body: _buildSignIn(context),
//     );
//   }

//   Widget _buildSignIn(BuildContext context) {
//     return signInManager.isLoading
//         ? const Spinner()
//         : Center(
//             child: LayoutBuilder(builder: (context, constraints) {
//               return SingleChildScrollView(
//                 child: Container(
//                   width: min(constraints.maxWidth, 600),
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       const SizedBox(height: 32.0),
//                       const SizedBox(
//                         height: 50.0,
//                         child: Text(
//                           Strings.signIn,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 32.0, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       const SizedBox(height: 32.0),
//                       SubmitButton(
//                         key: emailPasswordButtonKey,
//                         text: Strings.signInWithEmailPassword,
//                         onPressed: signInManager.isLoading
//                             ? null
//                             : () => _showEmailPasswordSignInPage(context),
//                         textColor: Colors.white,
//                         buttonColor: Theme.of(context).primaryColor,
//                         icon: Icons.email,
//                       ),
//                       const SizedBox(height: 8),
//                       SubmitButton(
//                         key: googlesignButtonKey,
//                         text: Strings.signinWithGoogle,
//                         buttonColor: Theme.of(context).primaryColor,
//                         textColor: Colors.white,
//                         imagePath: ('assets/images/google-logo.png'),
//                         onPressed: signInManager.isLoading
//                             ? null
//                             : signInManager.signInWithGoogle,
//                       ),
//                       const SizedBox(height: 8),
//                       SubmitButton(
//                         key: facebookSignButtonKey,
//                         text: Strings.signinWithFacebook,
//                         buttonColor: Theme.of(context).primaryColor,
//                         textColor: Colors.white,
//                         imagePath: ('assets/images/facebook-logo.png'),
//                         onPressed: signInManager.isLoading
//                             ? null
//                             : signInManager.signInWithFacebook,
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         Strings.or,
//                         style: TextStyle(fontSize: 14.0, color: Colors.black87),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       SubmitButton(
//                         key: anonymousButtonKey,
//                         text: Strings.signAnonymous,
//                         buttonColor: Theme.of(context).primaryColor,
//                         textColor: Colors.white,
//                         imagePath: ('assets/images/anonymous-logo.png'),
//                         onPressed: signInManager.isLoading
//                             ? null
//                             : signInManager.signInAnonymously,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           );
//   }
// }
class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInModel = ref.watch(signInManagerProvider);
      if (signInModel.error.isNotEmpty) {
        print("ABSSSSSSSSSSSSSSSSSS");
         showExceptionAlertDialog(
          context: context,
          title: Strings.signInFailed,
          exception: signInModel.error,
        );
      }

    return SignInPageContents(
      title: 'Riverpod Sign In',
      signInModel: signInModel,
    );
  }
}

class SignInPageContents extends StatelessWidget {
  const SignInPageContents(
      {Key? key, this.title = 'Architecture Demo', required this.signInModel})
      : super(key: key);
  final SignIn signInModel;
  final String title;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);
  static const Key googlesignButtonKey = Key(Keys.googleSign);
  static const Key facebookSignButtonKey = Key(Keys.facebookSign);

  Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.emailPasswordSignInPage,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: Consumer(builder: (_, WidgetRef ref, __) {
        final signInMode = ref.watch(signInManagerProvider.notifier);
        return _buildSignIn(context, signInMode);
      }),
    );
  }

  Widget _buildSignIn(BuildContext context, SignInManager signInMode) {
    return signInModel.isLoading
        ? const Spinner()
        : Center(
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Container(
                  width: min(constraints.maxWidth, 600),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 32.0),
                      const SizedBox(
                        height: 50.0,
                        child: Text(
                          Strings.signIn,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      SubmitButton(
                        key: emailPasswordButtonKey,
                        text: Strings.signInWithEmailPassword,
                        onPressed: signInModel.isLoading
                            ? null
                            : () => _showEmailPasswordSignInPage(context),
                        textColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 8),
                      SubmitButton(
                        key: googlesignButtonKey,
                        text: Strings.signinWithGoogle,
                        buttonColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        imagePath: ('assets/images/google-logo.png'),
                        onPressed: signInModel.isLoading
                            ? null
                            : signInMode.signInWithGoogle,
                      ),
                      const SizedBox(height: 8),
                      SubmitButton(
                        key: facebookSignButtonKey,
                        text: Strings.signinWithFacebook,
                        buttonColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        imagePath: ('assets/images/facebook-logo.png'),
                        onPressed: signInModel.isLoading
                            ? null
                            : signInMode.signInWithFacebook,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        Strings.or,
                        style: TextStyle(fontSize: 14.0, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      SubmitButton(
                        key: anonymousButtonKey,
                        text: Strings.signAnonymous,
                        buttonColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        imagePath: ('assets/images/anonymous-logo.png'),
                        onPressed: signInModel.isLoading
                            ? null
                            : signInMode.signInAnonymously,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
  }
}

// class SignInPage extends ConsumerWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final signInManagerNotifier = ref.watch(signInManagerProvider.notifier);
//     final signInListen = ref.watch(signInManagerProvider);
//     if (signInListen.error != null) {
//       showExceptionAlertDialog(
//         context: context,
//         title: Strings.signInFailed,
//         exception: signInListen.error,
//       );
//     } else if (signInListen.isLoading == true) {
//       return const Spinner();
//     }
//     return SignInPageContents(
//       signInManagerNotifier: signInManagerNotifier,
//       title: 'Riverpod Sign In',
//       signInListen: signInListen,
//     );
//   }
// }

// class SignInPageContents extends ConsumerWidget {
//   const SignInPageContents(
//       {Key? key,
//       required this.signInManagerNotifier,
//       required this.signInListen,
//       this.title = 'Architecture Demo'})
//       : super(key: key);
//   final SignInManager signInManagerNotifier;
//   final SignIn signInListen;
//   final String title;

//   static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
//   static const Key anonymousButtonKey = Key(Keys.anonymous);
//   static const Key googlesignButtonKey = Key(Keys.googleSign);
//   static const Key facebookSignButtonKey = Key(Keys.facebookSign);

//   Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
//     final navigator = Navigator.of(context);
//     await navigator.pushNamed(
//       AppRoutes.emailPasswordSignInPage,
//       arguments: () => navigator.pop(),
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 2.0,
//         title: Text(title),
//       ),
//       backgroundColor: Colors.grey[200],
//       body: _buildSignIn(context,ref),
//     );
//   }

//   Widget _buildSignIn(BuildContext context, WidgetRef ref) {
//     return Center(
//       child: LayoutBuilder(builder: (context, constraints) {
//         return SingleChildScrollView(
//           child: Container(
//             width: min(constraints.maxWidth, 600),
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 const SizedBox(height: 32.0),
//                 const SizedBox(
//                   height: 50.0,
//                   child: Text(
//                     Strings.signIn,
//                     textAlign: TextAlign.center,
//                     style:
//                         TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(height: 32.0),
//                 SubmitButton(
//                   key: emailPasswordButtonKey,
//                   text: Strings.signInWithEmailPassword,
//                   onPressed: ref.watch(signInManagerProvider).isLoading == false
//                       ? null
//                       : () => _showEmailPasswordSignInPage(context),
//                   textColor: Colors.white,
//                   buttonColor: Theme.of(context).primaryColor,
//                   icon: Icons.email,
//                 ),
//                 const SizedBox(height: 8),
//                 SubmitButton(
//                   key: googlesignButtonKey,
//                   text: Strings.signinWithGoogle,
//                   buttonColor: Theme.of(context).primaryColor,
//                   textColor: Colors.white,
//                   imagePath: ('assets/images/google-logo.png'),
//                   onPressed: ref.watch(signInManagerProvider).isLoading == false
//                       ? null
//                       : signInManagerNotifier.signInWithGoogle,
//                 ),
//                 const SizedBox(height: 8),
//                 SubmitButton(
//                   key: facebookSignButtonKey,
//                   text: Strings.signinWithFacebook,
//                   buttonColor: Theme.of(context).primaryColor,
//                   textColor: Colors.white,
//                   imagePath: ('assets/images/facebook-logo.png'),
//                   onPressed: ref.watch(signInManagerProvider).isLoading == false
//                       ? null
//                       : signInManagerNotifier.signInWithFacebook,
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   Strings.or,
//                   style: TextStyle(fontSize: 14.0, color: Colors.black87),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 SubmitButton(
//                   key: anonymousButtonKey,
//                   text: Strings.signAnonymous,
//                   buttonColor: Theme.of(context).primaryColor,
//                   textColor: Colors.white,
//                   imagePath: ('assets/images/anonymous-logo.png'),
//                   onPressed: ref.watch(signInManagerProvider).isLoading == false
//                       ? null
//                       : signInManagerNotifier.signInAnonymously,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
