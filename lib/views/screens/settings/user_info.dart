// import 'package:j4corp/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:j4corp/views/base/custom_loading.dart';
import 'package:j4corp/views/base/custom_networked_image.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfo extends StatefulWidget {
  final String title;
  final String data;
  const UserInfo({super.key, required this.title, required this.data});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final user = Get.find<UserController>();
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    user.getInfo(widget.data).then((val) {
      if (val == null) {
        customSnackbar("Error fetching ${widget.title}");
      } else {
        setState(() {
          data = val as Map<String, dynamic>;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: data == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CustomLoading(),
                  )
                : Column(
                    children: [
                      CustomNetworkedImage(
                        radius: 0,
                        url: data!['image'],
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 80,
                          top: 12,
                          left: 16,
                          right: 16,
                        ),
                        child: Html(
                          data:
                              cleanHtml(data!['description']) ??
                              "<p style=\"color: red; text-align: center;\">No Data has been uploaded</p>",
                          style: {
                            "p": Style(
                              fontSize: FontSize(16),
                              lineHeight: LineHeight(1.5),
                              color: Colors.white,
                            ),
                            "strong": Style(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize(16),
                              color: Colors.white,
                            ),
                            "em": Style(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                            "li": Style(
                              fontSize: FontSize(16),
                              color: Colors.white,
                            ),
                            "ul": Style(
                              padding: HtmlPaddings(left: HtmlPadding(20)),
                            ),
                            "ol": Style(
                              padding: HtmlPaddings(left: HtmlPadding(20)),
                            ),
                            "a": Style(
                              color: Colors.blueAccent,
                              textDecoration: TextDecoration.underline,
                            ),
                          },
                          onLinkTap: (url, attributes, element) {
                            if (url != null) {
                              launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  /// Cleans HTML from React Quill and other sources
  String? cleanHtml(String? rawHtml) {
    if (rawHtml == null || rawHtml.trim().isEmpty) return null;

    final unescape = HtmlUnescape();

    // Remove leading/trailing whitespace and fix smart quotes
    String cleaned = rawHtml
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll('’', "'")
        .replaceAll('\u2028', '') // line separator
        .replaceAll('\u00A0', ' ') // non-breaking space
        .replaceAll('\r', '');

    // Remove any leading closing tags that break flutter_html
    cleaned = cleaned.replaceAll(RegExp(r'^<\/p>|^<\/div>'), '');

    // Remove scripts for safety
    cleaned = cleaned.replaceAll(
      RegExp(r'<script[^>]*>.*?<\/script>', dotAll: true),
      '',
    );

    return unescape.convert(cleaned.trim());
  }
}
