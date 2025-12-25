import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/ai_chat_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_loading.dart';
import 'package:j4corp/views/screens/home/ai_chat.dart';

class AiAssistant extends StatefulWidget {
  const AiAssistant({super.key});

  @override
  State<AiAssistant> createState() => _AiAssistantState();
}

class _AiAssistantState extends State<AiAssistant> {
  final ai = Get.find<AiChatController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showingHistory = false;
  String? renameId;
  TextEditingController renameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AiChat(),
      appBar: CustomAppBar(
        title: "    AI Assistant",
        trailing: Container(),
        // trailing: IconButton(
        //   onPressed: () {
        //     _scaffoldKey.currentState?.openEndDrawer();
        //   },
        //   icon: Icon(Icons.menu_rounded),
        // ),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: showingHistory
                ? Column(
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showingHistory = false;
                          });
                        },
                        child: options("assets/icons/back.svg", "History"),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.gray.shade600,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Obx(
                            () => Column(
                              children: [
                                if (ai.fetchingChat.value)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomLoading(),
                                  ),
                                for (var i in ai.sessions)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16,
                                      right: 24,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ai.sessionId.value = i.sessionId;
                                        });
                                        Get.back();
                                        ai.getSessionHistory(i.sessionId).then((
                                          message,
                                        ) {
                                          if (message != "success") {
                                            customSnackbar(message);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:
                                              ai.sessionId.value == i.sessionId
                                              ? AppColors.blue[50]
                                              : AppColors.gray[50],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          spacing: 8,
                                          children: [
                                            Expanded(
                                              child: renameId != i.sessionId
                                                  ? Text(
                                                      i.title,
                                                      style: AppTexts.tmdr
                                                          .copyWith(
                                                            color: AppColors
                                                                .gray
                                                                .shade600,
                                                          ),
                                                    )
                                                  : TextField(
                                                      autofocus: true,
                                                      controller: renameCtrl,
                                                    ),
                                            ),
                                            if (renameId == i.sessionId)
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    renameId = null;
                                                  });
                                                  ai
                                                      .renameSession(
                                                        i.sessionId,
                                                        renameCtrl.text.trim(),
                                                      )
                                                      .then((message) {
                                                        if (message !=
                                                            "success") {
                                                          customSnackbar(
                                                            message,
                                                          );
                                                        }
                                                      });
                                                },
                                                child: Icon(Icons.check),
                                              ),
                                            if (renameId == i.sessionId)
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    renameId = null;
                                                  });
                                                },
                                                child: Icon(Icons.close),
                                              ),
                                            if (renameId != i.sessionId)
                                              SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: PopupMenuButton(
                                                  padding: EdgeInsets.zero,
                                                  iconColor:
                                                      AppColors.gray.shade600,
                                                  color: AppColors.white,
                                                  elevation: 10,
                                                  shadowColor: Colors.black,
                                                  icon: CustomSvg(
                                                    asset:
                                                        "assets/icons/more.svg",
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          setState(() {
                                                            renameId =
                                                                i.sessionId;
                                                          });
                                                        },
                                                        child: options(
                                                          "assets/icons/edit.svg",
                                                          "Rename",
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          ai
                                                              .deleteSession(
                                                                i.sessionId,
                                                              )
                                                              .then((message) {
                                                                if (message !=
                                                                    "success") {
                                                                  customSnackbar(
                                                                    message,
                                                                  );
                                                                }
                                                              });
                                                        },
                                                        child: options(
                                                          "assets/icons/delete.svg",
                                                          "Delete",
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: () {
                          ai.createSession().then((message) {
                            if (message != "success") {
                              customSnackbar(message);
                            }
                          });
                          Get.back();
                        },
                        child: options("assets/icons/new_chat.svg", "New Chat"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showingHistory = true;
                          });
                          ai.getSessions().then((message) {
                            if (message != "success") {
                              customSnackbar(message);
                            }
                          });
                        },
                        child: options("assets/icons/history.svg", "History"),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Row options(String asset, String text) {
    return Row(
      children: [
        CustomSvg(asset: asset, color: AppColors.gray.shade700, size: 24),
        const SizedBox(width: 16),
        Text(
          text,
          style: AppTexts.tmdr.copyWith(color: AppColors.gray.shade600),
        ),
      ],
    );
  }
}
