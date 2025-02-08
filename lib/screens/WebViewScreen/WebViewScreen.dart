import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String cookieName;
  final String value;
  final String domain;
  final String path;
  final String url;

  const WebViewScreen({
    super.key,
    required this.cookieName,
    required this.value,
    required this.domain,
    required this.path,
    required this.url,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    _setCookie();
  }

  void _setCookie() async {
    WebViewCookie cookie = WebViewCookie(
        name: widget.cookieName, value: widget.value, domain: widget.domain);
    await WebViewCookieManager().clearCookies();
    await WebViewCookieManager().setCookie(cookie);
    print("LOADING: ${widget.url}");
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Redirect",
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
