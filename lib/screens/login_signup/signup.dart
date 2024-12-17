import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/provider/user_provider.dart';
import 'package:movie_app/screens/login_signup/login.dart';
import 'package:movie_app/screens/login_signup/widgets/login_button_widget.dart';
import 'package:movie_app/screens/login_signup/widgets/login_text_form_field_widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String routeName = "signup_screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Column(
                  children: [
                    LoginTextFormFieldWidget(
                      controller: namecontroller,
                      hintText: AppLocalizations.of(context)!.name,
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.gold,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 2) {
                          return "name";
                        }
                        return null;
                      },
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
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.gold,
                      ),
                      password: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return AppLocalizations.of(context)!
                              .passwordValidator;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                                    .signup(
                                        UserModel(
                                            name: namecontroller.text,
                                            email: emailcontroller.text),
                                        passwordcontroller.text);
                                if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .isSignIn) {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.routeName);
                                }
                              }
                            },
                            text: AppLocalizations.of(context)!.signup),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.haveAcoount,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
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
