// {
//     "status": "success",
//     "device_id": "x",
//     "total_notifications": 3,
//     "notifications": [
//         {
//             "title": "حضور الطالب أحمد محمد",
//             "body": "حضر الطالب أحمد محمد حصة مجموعة الفيزياء أ - الثلاثاء 2026-04-29",
//             "created_at": "2026-04-29 10:30:00"
//         },
//         {
//             "title": "إذن غياب للطالب أحمد محمد",
//             "body": "الطالب/ة أحمد محمد عند المستر أحمد محمد علي استأذن للغياب أيام: 2026-04-30. السبب: ظروف عائلية",
//             "created_at": "2026-04-29 09:15:00"
//         },
//         {
//             "title": "إمتحان الفيزياء",
//             "body": "نحيط علم سيادتكم ان الطالب/ة أحمد محمد حصل علي 92 من أصل 100 درجة في إمتحان الفيزياء لدي مستر أحمد محمد علي",
//             "created_at": "2026-04-28 14:00:00"
//         }
//     ]
// }

import 'package:flutter/material.dart';

class NotificationsModel {
  final String status;
  final String deviceId;
  final int totalNotifications;
  final List<NotificationModel> notifications;

  NotificationsModel({
    required this.status,
    required this.deviceId,
    required this.totalNotifications,
    required this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      status: json['status'],
      deviceId: json['device_id'],
      totalNotifications: json['total_notifications'],
      notifications: List<NotificationModel>.from(json['notifications'].map((x) => NotificationModel.fromJson(x))),
    );
  }
}


class NotificationModel {
  final String title;
  final String body;
  final String createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
    );
  }

  // UI Helpers based on title/body keywords
  Color get color {
    if (title.contains('غياب') || title.contains('تنبيه')) {
      return const Color(0xFFE53935); // Red
    } else if (title.contains('إمتحان') || title.contains('درجة')) {
      return const Color(0xFF4CAF50); // Green
    } else if (title.contains('دفع') || title.contains('قسط')) {
      return const Color(0xFFFFC107); // Yellow
    } else if (title.contains('حضور') || title.contains('طلب')) {
      return const Color(0xFF2196F3); // Blue
    }
    return const Color(0xFF8F00FF); // Purple default
  }

  IconData get icon {
    if (title.contains('غياب') || title.contains('تنبيه')) {
      return Icons.calendar_today_outlined;
    } else if (title.contains('إمتحان') || title.contains('درجة')) {
      return Icons.star_border;
    } else if (title.contains('دفع') || title.contains('قسط')) {
      return Icons.account_balance_wallet_outlined;
    } else if (title.contains('حضور') || title.contains('طلب')) {
      return Icons.verified_user_outlined;
    }
    return Icons.notifications_none_outlined;
  }

  String get timeAgo {
    try {
      DateTime createdDate = DateTime.parse(createdAt);
      Duration diff = DateTime.now().difference(createdDate);
      if (diff.inDays > 0) {
        return 'منذ ${diff.inDays} يوم';
      } else if (diff.inHours > 0) {
        return 'منذ ${diff.inHours} ساعة';
      } else if (diff.inMinutes > 0) {
        return 'منذ ${diff.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return '';
    }
  }

  String? get extraData {
    // Basic logic to extract score if present (e.g. 92 من أصل 100)
    if (body.contains('حصل علي')) {
      final regExp = RegExp(r'(\d+) من أصل (\d+)');
      final match = regExp.firstMatch(body);
      if (match != null) {
        return '${match.group(1)}/${match.group(2)}';
      }
    }
    return null;
  }
}