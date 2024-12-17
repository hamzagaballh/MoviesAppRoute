import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/provider/user_provider.dart';
import 'package:movie_app/screens/bottom_nav.dart/bottom_nav_screen.dart';
import 'package:movie_app/screens/login_signup/signup.dart';
import 'package:movie_app/screens/login_signup/widgets/login_button_widget.dart';
import 'package:movie_app/screens/login_signup/widgets/login_text_form_field_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.2,
                      left: MediaQuery.of(context).size.width * 0.2,
                      right: MediaQuery.of(context).size.width * 0.2,
                      bottom: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Image.asset("assets/movies.png")),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                LoginTextFormFieldWidget(
                  controller: emailcontroller,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(
                    Icons.email,
                    color: AppColors.gold,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !isValidEmail(value)) {
                      return AppLocalizations.of(context)!.emailValidator;
                    }
                    return null;
                  },
                ),
                LoginTextFormFieldWidget(
                  controller: passwordcontroller,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.lock, color: AppColors.gold),
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return AppLocalizations.of(context)!.passwordValidator;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Column(
                  children: [
                    Provider.of<UserProvider>(context).loading
                        ? CircularProgressIndicator(
                            color: AppColors.gold,
                          )
                        : LoginButtonWidget(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .login(emailcontroller.text,
                                        passwordcontroller.text);
                                if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .isSignIn) {
                                  Navigator.of(context).pushReplacementNamed(
                                      BottomNavScreen.routeName);
                                }
                              }
                            },
                            text: AppLocalizations.of(context)!.login),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAccount,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignupScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.gold),
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
