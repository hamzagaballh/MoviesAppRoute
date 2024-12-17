import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/core/Colors.dart';
import 'package:movie_app/firebase/firebase_services.dart';
import 'package:movie_app/provider/localization_provider.dart';
import 'package:movie_app/screens/widget/settings_widgets/custom_listTile_settings_widget.dart';
import 'package:movie_app/screens/login_signup/login.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            right: 20,
            left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListtileSettingsWidget(
                title: AppLocalizations.of(context)!.language,
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(AppLocalizations.of(context)!.english,
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text(AppLocalizations.of(context)!.arabic,
                              style: Theme.of(context).textTheme.bodyLarge),
                        )
                      ],
                      iconEnabledColor: Colors.white,
                      dropdownColor: AppColors.gold,
                      borderRadius: BorderRadius.circular(20),
                      underline: Container(),
                      value: Provider.of<LocalizationProvider>(context,
                              listen: false)
                          .appLocal,
                      style: Theme.of(context).textTheme.titleSmall,
                      onChanged: (value) {
                        if (value != null) {
                          Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .changeLocal(value);
                        }
                      }),
                )),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                FirebaseServices.signout();
                Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
              },
              child: CustomListtileSettingsWidget(
                  title: AppLocalizations.of(context)!.signout,
                  trailing: Icon(
                    Icons.logout_outlined,
                    size: 40,
                    color: AppColors.gold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
