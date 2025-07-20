import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/user_session.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final user = await UserSession.getUser();
    setState(() {
      isLoggedIn = user['token'] != null && user['token']!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This line ensures rebuild on locale change
    final locale = context.locale;

    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row (Logo + Sections)
          Wrap(
            spacing: 40,
            runSpacing: 30,
            children: [
              // Logo & Mission
              SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'footer_logo'.tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'footer_mission'.tr(),
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Contact Info
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'footer_contact_info'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('footer_address_label'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('footer_address_value'.tr(), style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('footer_phone_label'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('footer_phone_value'.tr(), style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('footer_email_label'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('footer_email_value'.tr(), style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),

              // Categories
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'footer_categories'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('footer_category_men'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_category_women'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_category_kids'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_category_sport'.tr(), style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),

              // Navigate
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'footer_navigate'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('footer_nav_home'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_nav_about'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_nav_blog'.tr(), style: const TextStyle(color: Colors.white70)),
                    Text('footer_nav_categories'.tr(), style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Bottom Divider + Copyright
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'footer_copyright'.tr(),
              style: const TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
