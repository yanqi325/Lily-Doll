import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../component/AppBar.dart';
import '../constants.dart';

class CustomWebView extends StatefulWidget {
  static const String id = 'custom_webview';
  final String? url;

  CustomWebView({this.url});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(
          title: 'XXXX',
          colors: purple7,
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
