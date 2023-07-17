import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_app_test/cubit/webview_cubit.dart';

class WebviewPage extends StatefulWidget {
  static const routeName = '/webview';

  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  void initState() {
    BlocProvider.of<WebviewCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const _WebviewContent();
  }
}






class _WebviewContent extends StatefulWidget {
  const _WebviewContent({Key? key}) : super(key: key);

  @override
  State<_WebviewContent> createState() => _WebviewContentState();
}

class _WebviewContentState extends State<_WebviewContent> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true
  );

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WebviewCubit, WebviewState>(
        builder: (context, state) {
          if (state is WebviewError) {
            return Center(child: Text("Error ${state.message}"));
          } else if (state is WebviewLoaded) {
            return InAppWebView(
              initialUrlRequest:
              URLRequest(url: WebUri(state.url)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },




              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
              shouldOverrideUrlLoading:
                  (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                }

                return NavigationActionPolicy.ALLOW;
              },

            );

          } else if (state is WebviewEmptyURL) {
            return const Center(
              child: Text("Empty URL"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
//
// class _WebviewContent extends StatefulWidget {
//   const _WebviewContent({Key? key}) : super(key: key);
//
//   @override
//   State<_WebviewContent> createState() => _WebviewContentState();
// }
//
// class _WebviewContentState extends State<_WebviewContent> {
//   late WebViewController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//
//       ..addJavaScriptChannel('imageChannel', onMessageReceived: (message) {
//         final imageBase64 = message.message;
//       })
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('YOUR_IMAGE_UPLOAD_URL')) {
//               pickImage();
//               return NavigationDecision.prevent;
//             } if (request.url.startsWith('pickImageFromGallery')) {
//               pickImage();
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//   }
//
//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery, // Или ImageSource.camera для камеры
//     );
//
//     if (pickedFile != null) {
//       // Отправить выбранное изображение в WebView
//       final imageBytes = await pickedFile.readAsBytes();
//       final base64Image = base64Encode(imageBytes);
//       final script = 'handleImage("$base64Image")';
//       await _controller.runJavaScriptReturningResult(script);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<WebviewCubit, WebviewState>(
//         builder: (context, state) {
//           if (state is WebviewError) {
//             return Center(child: Text("Error ${state.message}"));
//           } else if (state is WebviewLoaded) {
//             return WebViewWidget(
//               controller: _controller
//                 ..loadRequest(
//                   Uri.parse(state.url),
//                 ),
//             );
//           } else if (state is WebviewEmptyURL) {
//             return const Center(
//               child: Text("Empty URL"),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
