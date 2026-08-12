import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const _backgroundColor = Color(0xFFC7D3F2);
  static const _cardColor = Color(0xFFFAF5F8);
  static const _contentBackgroundColor = Color(0xFFF3EDF2);
  static const _editButtonColor = Color(0xFF5367EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _HeaderSection(name: 'Evin')),

            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: _contentBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                child: const Column(
                  children: [
                    _AccountInfoCard(),
                    SizedBox(height: 16),
                    _SettingsOptionsCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String name;

  const _HeaderSection({required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 24.h),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 64.sp,
                  color: Colors.black.withValues(alpha: 0.35),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountInfoCard extends StatelessWidget {
  const _AccountInfoCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: SettingsView._cardColor,
          borderRadius: BorderRadius.circular(28.r),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const _ProfileDetailTile(
                icon: Icons.alternate_email_rounded,
                title: 'gyllinton',
                subtitle: 'Username',
              ),

              const _CustomDivider(),

              const _ProfileDetailTile(
                icon: Icons.phone_outlined,
                title: '+1 (123) 456-7890',
                subtitle: 'Phone',
              ),

              const _CustomDivider(),

              const _ProfileDetailTile(
                icon: Icons.info_outline,
                title: 'None',
                subtitle: 'Bio',
              ),
            ],
          ),
        ),

        Positioned(
          top: -20.h,
          right: 20.w,
          child: SizedBox(
            width: 48.w,
            height: 48.w,
            child: FloatingActionButton(
              onPressed: () {},
              elevation: 4,
              backgroundColor: SettingsView._editButtonColor,
              shape: const CircleBorder(),
              child: Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsOptionsCard extends StatelessWidget {
  const _SettingsOptionsCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SettingsView._cardColor,
      borderRadius: BorderRadius.circular(28.r),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const _SettingsNavigationTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
          ),

          const _CustomDivider(),

          const _SettingsNavigationTile(
            icon: Icons.lock_outline_rounded,
            title: 'Privacy and Security',
          ),

          const _CustomDivider(),

          const _SettingsNavigationTile(
            icon: Icons.color_lens_outlined,
            title: 'Themes and Chats',
          ),

          const _CustomDivider(),

          _SettingsNavigationTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            trailing: Switch(value: true, onChanged: (_) {}),
          ),

          const _CustomDivider(),

          const _SettingsNavigationTile(
            icon: Icons.people_alt_outlined,
            title: 'Invite Friends',
          ),

          const _CustomDivider(),

          const _SettingsNavigationTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileDetailTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Icon(icon, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 13.sp)),
      onTap: () {},
    );
  }
}

class _SettingsNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Widget? trailing;

  const _SettingsNavigationTile({
    required this.icon,
    required this.title,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      leading: Icon(icon, size: 24.sp, color: iconColor),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 64,
      color: Colors.black.withValues(alpha: 0.05),
    );
  }
}
