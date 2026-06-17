import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/profile/widgets/profile_settings_tile.dart';

class ProfileSettingsCard extends StatefulWidget {
  final VoidCallback? onAppSettings;
  final ValueChanged<bool>? onNotificationsChanged;
  final VoidCallback? onPrivacy;

  const ProfileSettingsCard({
    super.key,
    this.onAppSettings,
    this.onNotificationsChanged,
    this.onPrivacy,
  });

  @override
  State<ProfileSettingsCard> createState() => _ProfileSettingsCardState();
}

class _ProfileSettingsCardState extends State<ProfileSettingsCard> {
  bool _notificationsEnabled = true;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
  }

  void _loadNotificationStatus() {
    setState(() {
      _notificationsEnabled = _storageService.getBool(
        'notifications_enabled',
        defaultValue: true,
      );
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _storageService.save('notifications_enabled', value);
    if (widget.onNotificationsChanged != null) {
      widget.onNotificationsChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.cardBackground,
            AppColors.cardBackgroundLight.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          ProfileSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'تفضيلات الإشعارات',
            trailing: Switch.adaptive(
              value: _notificationsEnabled,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
              onChanged: _toggleNotifications,
            ),
            onTap: () => _toggleNotifications(!_notificationsEnabled),
          ),
          Divider(color: AppColors.outlineVariant, height: 1),
          ProfileSettingsTile(
            icon: Icons.lock_outline,
            title: 'الخصوصية والأمان',
            onTap: widget.onPrivacy,
          ),
        ],
      ),
    );
  }
}
