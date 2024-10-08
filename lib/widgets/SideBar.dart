import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/screens/Login/LoginScreen.dart';
import 'package:dy_integrated_5/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(1),
      // shadowColor: Theme.of(context).colorScheme.primary,
      // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FDY",
              textScaler: const TextScaler.linear(1.5),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              leading: const Icon(Icons.verified_user),
              title: Consumer(
                builder: (context, ref, child) {
                  final username = ref.watch(usernameProvider);
                  return username.when(
                      data: (data) {
                        if (data == null) {
                          return const Text("No user");
                        } else {
                          // username is basically a mail ID
                          // Splitting the domain and the username to access the username for display
                          data = data.split("@")[0];
                          return Text(data);
                        }
                      },
                      error: (err, stackTrace) =>
                          const Text("Something went wrong"),
                      loading: () => const Text("Loading..."));
                },
              ),
              subtitle: const Text("Current User"),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              leading: const Icon(Icons.color_lens),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              title: const Text("Personalisation"),
              subtitle: const Text("Pick a Theme!"),
              onTap: () {
                showSnackBar("Not Implemented", 1000);
                Scaffold.of(context).closeDrawer();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              leading: const Icon(Icons.code_rounded),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              title: const Text("Application"),
              subtitle: const Text("Source Code"),
              onTap: () async {
                Uri uri =
                    Uri.parse("https://github.com/whiskas101/LMS-Flutter");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              leading: const Icon(Icons.electrical_services_rounded),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              title: const Text("Backend"),
              onTap: () async {
                Uri uri = Uri.parse("https://github.com/whiskas101/DYP-flask");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              subtitle: const Text("Source Code"),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              leading: const Icon(Icons.logout_rounded),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              title: const Text("Log Out"),
              onTap: () {
                const FlutterSecureStorage().deleteAll();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              subtitle: const Text("Data will persist"),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              leading: const Icon(Icons.delete_forever),
              tileColor:
                  Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
              title: const Text("Clear App Data"),
              onTap: () {
                showSnackBar("Not Implemented", 1000);
                Scaffold.of(context).closeDrawer();
              },
              subtitle: const Text("Re-downloadable"),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
