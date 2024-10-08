import 'dart:convert';

import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:dy_integrated_5/screens/WebViewScreen/WebViewScreen.dart';

import 'package:dy_integrated_5/services/api_service.dart';
import 'package:dy_integrated_5/services/db_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Playground extends StatefulWidget {
  Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  WebViewCookie cookie = const WebViewCookie(
      name: "MoodleSession",
      value: "b9eosbnne5s0ovam27b2kkgd20",
      domain: "mydy.dypatil.edu",
      path: "/rait/");

  @override
  void initState() {
    super.initState();
    _setCookie();
  }

  void _setCookie() async {
    await WebViewCookieManager().clearCookies();
    await WebViewCookieManager().setCookie(cookie);
  }

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(onPageStarted: (String url) {
      //someting
    }, onPageFinished: (String url) {
      //something else
    }))
    ..loadRequest(Uri.parse('https://mydy.dypatil.edu/rait/my/'));

  @override
  Widget build(BuildContext context) {
    // final apiService = ref.watch(apiServiceProvider);
    // final semester = ref.watch(semesterNotifierProvider);
    // final materials = ref.watch(courseMaterialProvider);

    // final timetable = ref.read(timetableNotifierProvider);

    var res = WebViewCookieManager().setCookie(cookie);
    print(res);

    return WebViewScreen(
        cookieName: "thest",
        value: "test",
        domain: "test",
        path: "path",
        url: "https://google.com");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "test",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(WebViewCookieManager());
          final cookies =
              await controller.runJavaScriptReturningResult('document.cookie');
          print(cookies);
          print(WebViewCookieManager());
        },
      ),
    );
  }
}

              // Container(
              //   child: ElevatedButton(
              //     onPressed: doStuff,
              //     child: const Text("do stuff"),
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     ref.read(semesterNotifierProvider.notifier).getSemesterData();
              //   },
              //   child: const Text("do subject stuff"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     ref.read(courseMaterialProvider.notifier).getCourseMaterials(
              //         "https://mydy.dypatil.edu/rait/course/view.php?id=5922");
              //   },
              //   child: const Text("do material stuff"),
              // ),
              // ElevatedButton(
              //   onPressed: doDownloadStuff,
              //   child: const Text("do download stuff"),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(onPressed: pushToDB, child: Text("Datapush")),
              // ElevatedButton(
              //     onPressed: () {
              //       ref.read(timetableNotifierProvider.notifier).getTimeTable();
              //     },
              //     child: Text("Get timetable"))

