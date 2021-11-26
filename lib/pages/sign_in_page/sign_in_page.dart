import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_button.dart';
import 'package:riverpod_flutter_register_login_firebase/pages/sign_in_page/sign_in_manager.dart';
import 'package:riverpod_flutter_register_login_firebase/providers/top_level_providers.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/keys.dart';
import 'package:riverpod_flutter_register_login_firebase/constants/strings.dart';
import 'package:riverpod_flutter_register_login_firebase/routing/app_router.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/alerts/exception_alert_dialog.dart';

final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(auth: ref.watch(firebaseAuthProvider)),
);

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInModel = ref.watch(signInModelProvider);
    ref.listen<SignInViewModel>(signInModelProvider, (_, model) async {
      if (model.error != null) {
        await showExceptionAlertDialog(
          context: context,
          title: Strings.signInFailed,
          exception: model.error,
        );
      }
    });
    return SignInPageContents(
      viewModel: signInModel,
      title: 'Architecture Demo',
    );
  }
}

class SignInPageContents extends StatelessWidget {
  const SignInPageContents(
      {Key? key, required this.viewModel, this.title = 'Architecture Demo'})
      : super(key: key);
  final SignInViewModel viewModel;
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
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return viewModel.isLoading
        ? _buildHeader()
        : Center(
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
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
                    SignInButton(
                      key: emailPasswordButtonKey,
                      text: Strings.signInWithEmailPassword,
                      onPressed: viewModel.isLoading
                          ? null
                          : () => _showEmailPasswordSignInPage(context),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 8),
                    SignInButton(
                      key: googlesignButtonKey,
                      text: Strings.signinWithGoogle,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: viewModel.isLoading
                          ? null
                          : viewModel.signInWithGoogle,
                    ),
                    const SizedBox(height: 8),
                    SignInButton(
                      key: facebookSignButtonKey,
                      text: Strings.signinWithFacebook,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: viewModel.isLoading
                          ? null
                          : viewModel.signInWithFacebook,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      Strings.or,
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    SignInButton(
                      key: anonymousButtonKey,
                      text: Strings.signAnonymous,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: viewModel.isLoading
                          ? null
                          : viewModel.signInAnonymously,
                    ),
                  ],
                ),
              );
            }),
          );
  }
}
