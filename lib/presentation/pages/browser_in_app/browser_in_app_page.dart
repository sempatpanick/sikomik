import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/const.dart';
import '../../widgets/shimmer_effect.dart';
import '../../widgets/skeleton_text_widget.dart';

class BrowserInAppPage extends StatefulWidget {
  static const String routeName = "/browser_in_app";
  final String url;

  const BrowserInAppPage({super.key, required this.url});

  @override
  State<BrowserInAppPage> createState() => _BrowserInAppPageState();
}

class _BrowserInAppPageState extends State<BrowserInAppPage> {
  late WebViewController webViewController;
  int loadingPageProgress = 0;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPageProgress = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: loadingPageProgress < 100
            ? null
            : ShimmerEffect(
                linearGradient: linearGradientShimmer,
                child: FutureBuilder<String?>(
                  future: webViewController.getTitle(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SkeletonTextWidget();
                    }

                    return Text(
                      snapshot.data ?? "",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
        actions: [
          IconButton(
            onPressed: webViewController.reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: loadingPageProgress == 100
            ? null
            : PreferredSize(
                preferredSize: const Size(double.infinity, 3),
                child: LinearProgressIndicator(
                  value: loadingPageProgress / 100,
                  color: theme.primaryColor,
                ),
              ),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
