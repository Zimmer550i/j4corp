import 'package:flutter/material.dart';
import 'package:template/utils/app_colors.dart';

class PullToRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final ScrollController? controller;

  const PullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.controller,
  });

  @override
  PullToRefreshState createState() => PullToRefreshState();
}

class PullToRefreshState extends State<PullToRefresh> {
  bool isRefreshing = false;
  double beginY = 0;
  double size = 0;
  final double thresholdMin = 80;
  final double thresholdMax = 200;
  final double edgeOffset = 100;
  final double iconSize = 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: start,
      onPanUpdate: update,
      onPanEnd: end,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (widget.controller != null && widget.controller!.offset <= 0) {
                if (notification is ScrollStartNotification) {
                  if (notification.dragDetails != null) {
                    start(notification.dragDetails);
                  }
                } else if (notification is ScrollUpdateNotification) {
                  if (notification.dragDetails != null) {
                    update(notification.dragDetails);
                  }
                } else if (notification is ScrollEndNotification) {
                  if (notification.dragDetails != null) {
                    end(notification.dragDetails);
                  }
                }
              }

              return true;
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: widget.controller != null ? 0 : size,
              ),
              child: widget.child,
            ),
          ),
          Positioned(
            top: getLoadingPosition - iconSize,
            child: Opacity(
              opacity: getOpacity,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    color: AppColors.blue[400],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: AppColors.blue[800]!.withAlpha(100),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void end(details) {
    setState(() {
      if (size > thresholdMin && !isRefreshing) {
        _refresh();
      }
      size = 0;
    });
  }

  void update(details) {
    setState(() {
      final temp = details.localPosition.dy - beginY;
      if (temp > 0 && !isRefreshing) {
        size = temp < thresholdMax ? temp : thresholdMax;
      } else {
        size = 0;
      }
    });
  }

  void start(details) {
    setState(() {
      beginY = details.localPosition.dy;
    });
  }

  double get getLoadingPosition {
    if (size > edgeOffset || isRefreshing) {
      return edgeOffset;
    } else {
      return size;
    }
  }

  double get getOpacity {
    if (isRefreshing || size > edgeOffset) {
      return 1;
    } else if (size == 0) {
      return 0;
    } else if (size <= edgeOffset) {
      return size / edgeOffset;
    }

    return 0;
  }

  Future<void> _refresh() async {
    setState(() {
      isRefreshing = true;
    });

    await widget.onRefresh();

    setState(() {
      isRefreshing = false;
    });
  }
}
