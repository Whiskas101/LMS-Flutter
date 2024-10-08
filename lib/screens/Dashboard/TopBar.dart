import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/services/api_service.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerStatefulWidget {
  const TopBar({super.key});

  @override
  ConsumerState<TopBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<TopBar> {
  final refreshThrottler = Throttler();

  @override
  Widget build(BuildContext context) {
    final apiService = ref.watch(apiServiceProvider);
    print("Logged in?: ");
    print("Last login: ${apiService.lastLoginAttempt}");
    print(DateTime.now().difference(apiService.lastLoginAttempt));
    // const Duration(minutes: 30));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        const Expanded(
          child: SizedBox(
            width: 10,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: DateTime.now().difference(apiService.lastLoginAttempt) <
                  const Duration(minutes: 30)
              ? const Icon(Icons.signal_cellular_alt_rounded)
              : Icon(
                  Icons.signal_cellular_alt_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            refreshThrottler.run(() async {
              await ref
                  .read(semesterNotifierProvider.notifier)
                  .getSemesterData(forceReFetch: true);
              setState(() {
                //For forcing the update on the signal widget [This is a bandaid because I dont want to have an API stateNotifier for now]
              });
            });
          },
          child: const Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }
}
