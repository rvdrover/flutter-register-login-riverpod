import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/buttons/submit_button.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_manager.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/commen_strings.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/providers.dart';
import 'package:riverpod_flutter_register_login_firebase/routing/app_router.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/spinner/spinner.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignIn>(signInManagerProvider, (_, signIn) async {
      if (signIn.error != null) {
        await showExceptionAlertDialog(
          context: context,
          title: Strings.signInFailed,
          exception: signIn.error,
        );
      }
    });
    return const SignInPageContents(
      title: 'Riverpod FireBase Social Sign',
    );
  }
}

class SignInPageContents extends StatelessWidget {
  const SignInPageContents({Key? key, this.title=""})
      : super(key: key);
  final String title;
  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);
  static const Key googlesignButtonKey = Key(Keys.googleSign);
  static const Key facebookSignButtonKey = Key(Keys.facebookSign);
  static const Key twitterSignButtonKey = Key(Keys.twitterSign);
  static const Key githubSignButtonKey = Key(Keys.githubSign);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: Consumer(builder: (_, WidgetRef ref, __) {
        final signInNotifier = ref.watch(signInManagerProvider.notifier);
        final signIn = ref.watch(signInManagerProvider);
        return signIn.isLoading
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
                            onPressed: signIn.isLoading
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
                            onPressed: signIn.isLoading
                                ? null
                                : signInNotifier.signInWithGoogle,
                          ),
                          const SizedBox(height: 8),
                          SubmitButton(
                            key: facebookSignButtonKey,
                            text: Strings.signinWithFacebook,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            imagePath: ('assets/images/facebook-logo.png'),
                            onPressed: signIn.isLoading
                                ? null
                                : signInNotifier.signInWithFacebook,
                          ),
                          const SizedBox(height: 8),
                          SubmitButton(
                            key: twitterSignButtonKey,
                            text: Strings.signinWithTwitter,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            imagePath: ('assets/images/twitter-logo.png'),
                            onPressed: signIn.isLoading
                                ? null
                                : signInNotifier.signInWithTwitter,
                          ),
                          const SizedBox(height: 8),
                          SubmitButton(
                            key: githubSignButtonKey,
                            text: Strings.signinWithGithub,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            imagePath: ('assets/images/github-logo.png'),
                            onPressed: () => signIn.isLoading
                                ? null
                                : signInNotifier.signInWithGithub(context),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            Strings.or,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          SubmitButton(
                            key: anonymousButtonKey,
                            text: Strings.signAnonymous,
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            imagePath: ('assets/images/anonymous-logo.png'),
                            onPressed: signIn.isLoading
                                ? null
                                : signInNotifier.signInAnonymously,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
      }),
    );
  }

  Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.emailPasswordSignInPage,
      arguments: () => navigator.pop(),
    );
  }
}
