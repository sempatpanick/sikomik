import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../common/const.dart';
import '../../../main.dart';
import '../../controllers/main_controller.dart';
import '../main/main_page.dart';

class BrowserInAppPage extends StatefulWidget {
  static const String routeName = "/browser/:path";

  const BrowserInAppPage({super.key});

  @override
  State<BrowserInAppPage> createState() => _BrowserInAppPageState();
}

class _BrowserInAppPageState extends State<BrowserInAppPage> {
  InAppWebViewController? webViewController;
  int loadingPageProgress = 0;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  PullToRefreshController? pullToRefreshController;
  String url = "$baseUrl/terms-and-conditions";
  String title = "";

  @override
  void initState() {
    if (Get.parameters['path'] != null) {
      url = "$baseUrl/${Get.parameters['path']!}";
    }
    pullToRefreshController = kIsWeb ||
            kIsWasm ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                  ),
                );
              }
            },
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () async {
            final isCanPop = await Navigator.of(context).maybePop();
            if (!isCanPop) {
              final mainController = Get.find<MainController>();
              mainController.changeSelectedIndexNav(1);
              Get.offAllNamed(
                MainPage.routeName,
                arguments: 1,
              );
            }
          },
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_outlined,
              color: theme.primaryColor,
            ),
          ),
        ),
        title: loadingPageProgress < 100
            ? null
            : Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          IconButton(
            onPressed: webViewController?.reload,
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
      body: InAppWebView(
        webViewEnvironment: webViewEnvironment,
        initialUrlRequest: URLRequest(
          url: WebUri(url),
        ),
        initialSettings: settings,
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) async {
          setState(() {
            webViewController = controller;
          });
        },
        onLoadStart: (controller, url) {},
        onPermissionRequest: (controller, request) async {
          return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT,
          );
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          // var uri = navigationAction.request.url!;
          //
          // if (![
          //   "http",
          //   "https",
          //   "file",
          //   "chrome",
          //   "data",
          //   "javascript",
          //   "about"
          // ].contains(uri.scheme)) {
          //   if (await canLaunchUrl(uri)) {
          //     // Launch the App
          //     await launchUrl(
          //       uri,
          //     );
          //     // and cancel the request
          //     return NavigationActionPolicy.CANCEL;
          //   }
          // }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          pullToRefreshController?.endRefreshing();
        },
        onReceivedError: (controller, request, error) {
          pullToRefreshController?.endRefreshing();
        },
        onProgressChanged: (controller, progress) {
          setState(() {
            loadingPageProgress = progress;
          });
          if (progress == 100) {
            pullToRefreshController?.endRefreshing();
          }
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {},
        onTitleChanged: (controller, title) {
          setState(() {
            this.title = title ?? "";
          });
        },
      ),
    );
  }
}
