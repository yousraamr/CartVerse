import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/user_session.dart';
import '../view/drawer_widget.dart';
import '../view/footer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await UserSession.getUser();
    setState(() {
      firstName = user['firstName'] ?? 'Guest';
      lastName = user['lastName'] ?? '';
      email = user['email'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile_title'.tr())),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5E6),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'profile_account_info'.tr(),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('profile_first_name'.tr(), firstName ?? ''),
                    _buildInfoRow('profile_last_name'.tr(), lastName ?? ''),
                    _buildInfoRow('profile_email'.tr(), email ?? ''),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: const Footer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 4),
        ],
      ),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
