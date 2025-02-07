import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../core/extensions/locale_extension.dart';
import '../../core/localization/localization.dart';
import '../view_model/settings_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsViewModel viewModel;

  const SettingsScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(AppLocalization.of(context).language),
              trailing: Text(
                AppLocalization.of(context).locale.titleNative,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () => context.push(Routes.settings + Routes.language),
            ),
          ],
        ),
      ),
    );
  }
}
