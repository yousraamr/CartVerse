import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: double.infinity,
      child: const Column(
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
                      'CARTVERSE',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our mission is to offer you the best selection of stylish and high-quality clothing, whether from well-known brands or emerging designers.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
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
                      'CONTACT INFO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('ADDRESS:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('105 New Cairo, Cairo, Egypt', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text('PHONE:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('+(201) 060-472-366', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text('EMAIL:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('fixedmasr@cartverse.com', style: TextStyle(color: Colors.white70)),
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
                      'CATEGORIES',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Men\'s Clothing', style: TextStyle(color: Colors.white70)),
                    Text('Women\'s Clothing', style: TextStyle(color: Colors.white70)),
                    Text('Kid\'s Clothing', style: TextStyle(color: Colors.white70)),
                    Text('Sport\'s Clothing', style: TextStyle(color: Colors.white70)),
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
                      'NAVIGATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Home', style: TextStyle(color: Colors.white70)),
                    Text('About', style: TextStyle(color: Colors.white70)),
                    Text('Blog', style: TextStyle(color: Colors.white70)),
                    Text('Categories', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),

           SizedBox(height: 40),

          // Bottom Divider + Copyright
           Divider(color: Colors.white24),
           SizedBox(height: 10),
           Center(
            child: Text(
              'Copyright © 2025 Cartverse By Yousra Amr.\nAll Rights Reserved',
              style: TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
