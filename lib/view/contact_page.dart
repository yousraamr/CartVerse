import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'drawer_widget.dart';
import 'footer.dart';
import 'location_map.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: double.infinity,
                  child: Image.network(
                    'https://cart-verse.netlify.app/assets/contact-banner-Dr5vILaK.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'contact_hero_title'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'contact_hero_subtitle'.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Contact Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'contact_info_title'.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 40,
                          runSpacing: 20,
                          children: [
                            // Email
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'contact_email_label'.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'contact_email_value',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            // Phone
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'contact_phone_label'.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                   Text(
                                    'contact_phone_value'.tr(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                            // Address
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'contact_address_label'.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                   Text(
                                    'contact_address_value'.tr(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Send us a message section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'contact_form_title'.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'contact_form_name'.tr(),
                      hintText: 'contact_form_name_hint'.tr(),
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'contact_form_email'.tr(),
                      hintText: 'contact_form_email_hint'.tr(),
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subject Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'contact_form_subject'.tr(),
                      hintText: 'contact_form_subject_hint'.tr(),
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Message Field
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'contact_form_message'.tr(),
                      hintText: 'contact_form_message_hint'.tr(),
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Send Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB8860B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('contact_form_button'.tr()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Location section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'contact_location_title'.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LocationMap(),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }
}