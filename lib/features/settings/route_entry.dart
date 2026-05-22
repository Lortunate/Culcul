import 'package:culcul/features/settings/presentation/pages/about_page.dart';
import 'package:culcul/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/widgets.dart';

Widget buildSettingsRoutePage({required VoidCallback onOpenAbout}) {
  return SettingsPage(onOpenAbout: onOpenAbout);
}

Widget buildAboutRoutePage() => const AboutPage();
