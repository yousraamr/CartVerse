import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'We\'d love to hear from you! Get in touch with us today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
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
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'support@cartverse.com',
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
                                    'PHONE',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '+20 123 456 7890',
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
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '123 Fashion Street, Cairo, Egypt',
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
                  const Text(
                    'Send Us a Message',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subject Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      hintText: 'Enter the subject',
                      border: borderStyle,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Message Field
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Enter your message',
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
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Location section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Location',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  LocationMap(),
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
