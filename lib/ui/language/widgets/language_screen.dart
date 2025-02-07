import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/locale_extension.dart';
import '../../core/localization/localization.dart';
import '../view_model/language_viewmodel.dart';

class LanguageScreen extends StatefulWidget {
  final LanguageViewModel viewModel;

  const LanguageScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.updateLocale.addListener(
      () {
        if (!mounted) return;

        if (widget.viewModel.updateLocale.running) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => PopScope(
              canPop: false,
              child: Center(
                child: Container(
                  width: 112,
                  height: 112,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).language),
      ),
      body: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) => Column(
            children: [
              RadioListTile(
                value: null,
                groupValue: widget.viewModel.locale,
                title: Text(AppLocalization.of(context).systemDefault),
                onChanged: (_) => widget.viewModel.updateLocale.execute(null),
              ),
              ...AppLocalization.supportedLocales.map(
                (locale) => RadioListTile(
                  value: locale,
                  subtitle: Text(locale.title),
                  groupValue: widget.viewModel.locale,
                  title: Text(locale.titleNative),
                  onChanged: widget.viewModel.updateLocale.execute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
