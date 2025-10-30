import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/screens/home/ai_chat.dart';

class AiAssistant extends StatefulWidget {
  const AiAssistant({super.key});

  @override
  State<AiAssistant> createState() => _AiAssistantState();
}

class _AiAssistantState extends State<AiAssistant> {
  bool showingHistory = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                          child: Column(
                            children: [
                              for (int i = 0; i < 20; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                    right: 24,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.blue[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Chat Name",
                                          style: AppTexts.tmdr.copyWith(
                                            color: AppColors.gray.shade600,
                                          ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: PopupMenuButton(
                                            padding: EdgeInsets.zero,
                                            iconColor: AppColors.gray.shade600,
                                            color: AppColors.white,
                                            elevation: 10,
                                            shadowColor: Colors.black,
                                            icon: CustomSvg(
                                              asset: "assets/icons/more.svg",
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  child: options(
                                                    "assets/icons/edit.svg",
                                                    "Rename",
                                                  ),
                                                ),
                                                PopupMenuItem(
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    spacing: 24,
                    children: [
                      options("assets/icons/new_chat.svg", "New Chat"),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showingHistory = true;
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
        CustomSvg(asset: asset, color: AppColors.gray.shade700, size: 24,),
        const SizedBox(width: 16),
        Text(
          text,
          style: AppTexts.tmdr.copyWith(color: AppColors.gray.shade600),
        ),
      ],
    );
  }
}
