import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app.router.dart';
import '../constants/constants.dart';
import '../constants/current_page.enum.dart';
import '../pods/auth.pod.dart';

class LoginButton extends HookConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController tokenController;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.tokenController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // * notify login user state via the provider
          await ref.read(authStateNotifierPod.notifier).loginUser(
                emailController.text,
                passwordController.text,
                tokenController.text,
              );

          goToPage(context: context, ref: ref, pageToGo: CURRENT_PAGE.home);
        },
        child: Text(
          'LOG IN',
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(defaultPadding),
          primary: primaryColor,
        ),
      ),
    );
  }
}
