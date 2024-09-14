import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/CourseMaterial.dart';
import '../models/Subject.dart';
import '../providers/DatabaseProvider.dart';
import '../services/api_service.dart';

class CustomListTile extends ConsumerWidget {
  final int index;
  final List<CourseMaterial> filteredMaterials;
  final Subject subject;
  const CustomListTile(
      {super.key,
      required this.index,
      required this.filteredMaterials,
      required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Throttler _throttler = Throttler();
    final apiService = ref.read(apiServiceProvider);

    return ListTile(
      onTap: () {
        ref
            .read(databaseNotifierProvider.notifier)
            .insert(filteredMaterials[index], subject.name);
        _throttler.run(() {
          apiService.downloadResource(subject.name,
              filteredMaterials[index].name, filteredMaterials[index].link);
        });
        // ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link);
      },

      leading: Icon(Icons.dashboard,
          size: 32,
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
      title: Row(
        children: [
          Expanded(
            // File name
            child: Text(
              filteredMaterials[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ), //File Type
      subtitle: Text(filteredMaterials[index].type,
          style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4))),
      trailing: PopupMenuButton(
        enableFeedback: true,
        iconSize: 28,
        // onPressed: () => {
        //   apiService.downloadResource(subject.name,
        //       filteredMaterials[index].name, filteredMaterials[index].link,
        //       forceReFetch: true)
        // },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                child: const Text("Download"),
                onTap: () => {
                      apiService.downloadResource(
                          subject.name,
                          filteredMaterials[index].name,
                          filteredMaterials[index].link,
                          forceReFetch: true)
                    }),
            PopupMenuItem(
              child: const Text("Delete"),
              onTap: () =>
                  {showSnackBar("This feature is currently unavailable", 500)},
            )
          ];
        },
        icon: Icon(
          Icons.more_vert_rounded,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        ),
      ),
    );
  }
}
