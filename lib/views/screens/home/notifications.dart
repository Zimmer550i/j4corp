import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/notification_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Map<DateTime, List<Map<String, dynamic>>> data = {
    DateTime.now(): [
      {
        "title": "Deadline Reminder",
        "text":
            "Your campaign “Adidas Running” requires you to upload performance metrics",
        "read": false,
        "type": "soft",
      },
      {
        "title": "Deadline Reminder",
        "text":
            "Your campaign “Adidas Running” requires you to upload performance metrics",
        "read": false,
        "type": "soft",
      },
      {
        "title": "Deadline Reminder",
        "text":
            "Your campaign “Adidas Running” requires you to upload performance metrics",
        "read": false,
        "type": "soft",
      },
    ],
    DateTime.now().subtract(Duration(days: 1)): [
      {
        "title": "Quick Check-in",
        "text": "Have you recorded your content for “Coca-Cola Summer Ad” ?",
        "read": true,
        "type": "hard",
      },
      {
        "title": "Your Payment is in Process!",
        "text":
            "Your payment for “Nike Air Max” (\$500) is being processed. Expected payment: February 20, 2025.",
        "read": true,
        "type": "soft",
      },
      {
        "title": "Quick Check-in",
        "text": "Have you recorded your content for “Coca-Cola Summer Ad” ?",
        "read": true,
        "type": "hard",
      },
      {
        "title": "Your Payment is in Process!",
        "text":
            "Your payment for “Nike Air Max” (\$500) is being processed. Expected payment: February 20, 2025.",
        "read": true,
        "type": "soft",
      },
    ],
    DateTime.now().subtract(Duration(days: 2)): [
      {
        "title": "Campaign Submission Declined",
        "text":
            "Your submission for “Coca-Cola Summer Ad” was declined due to missing details",
        "read": true,
        "type": "soft",
      },
      {
        "title": "Payment Reminder: Invoice Due Soon",
        "text":
            "Your payment for the “Nike Air Max” campaign is scheduled for March 5, 2025. Ensure your invoice is correctly uploaded",
        "read": true,
        "type": "soft",
      },
      {
        "title": "Payment Reminder: Invoice Due Soon",
        "text":
            "Your payment for the “Nike Air Max” campaign is scheduled for March 5, 2025. Ensure your invoice is correctly uploaded",
        "read": true,
        "type": "soft",
      },
      {
        "title": "Payment Reminder: Invoice Due Soon",
        "text":
            "Your payment for the “Nike Air Max” campaign is scheduled for March 5, 2025. Ensure your invoice is correctly uploaded",
        "read": true,
        "type": "soft",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notificaitons"),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        color: AppColors.blue,
        backgroundColor: AppColors.indigo,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: getNotifications(data)),
        ),
      ),
    );
  }

  List<Widget> getNotifications(
    Map<DateTime, List<Map<String, dynamic>>> data,
  ) {
    List<Widget> rtn = [];

    final sortedKeys = data.keys.toList()..sort((a, b) => b.compareTo(a));

    for (var i in sortedKeys) {
      rtn.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formatDate(i),
              style: AppTexts.tmdr,
            ),
          ),
        ),
      );
      for (var j in data[i]!) {
        rtn.add(NotificationWidget(item: j, showBoarder: data[i]!.last != j));
      }
    }

    rtn.add(const SizedBox(height: 50));

    return rtn;
  }

  String formatDate(DateTime t) {
    final now = DateTime.now();
    final List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    if (t.year == now.year && t.month == now.month && t.day == now.day) {
      return "Today";
    } else if (t.year == now.year &&
        t.month == now.month &&
        now.day - t.day == 1) {
      return "Yesterday";
    } else if (t.year == now.year &&
        t.month == now.month &&
        t.day - now.day == 1) {
      return "Tomorrow";
    } else {
      return "${t.day} ${months[t.month - 1]} ${t.year}";
    }
  }
}
