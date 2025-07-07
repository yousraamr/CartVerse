import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Flannel Shirt',
      'price': '1050.00 EGP',
      'image': 'assets/images/img-1.jpg',
    },
    {
      'name': 'Striped Shirt',
      'price': '949.00 EGP',
      'image': 'assets/images/img-2.jpg',
    },
    {
      'name': 'Cotton Hoodie',
      'price': '1200.00 EGP',
      'image': 'assets/images/img-3.jpg',
    },
    {
      'name': 'Dress Shirt',
      'price': '1800.00 EGP',
      'image': 'assets/images/img-4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Image.network(
                    'https://cart-verse.netlify.app/assets/hero-CJhwK5Io.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'WINTER 2025',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Enjoy Our\nLuxury Collection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text(
                            'SHOP NOW',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // New Arrivals Section
            const SizedBox(height: 40),
            const Text(
              'New Arrivals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Discover the latest trends',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Product List
            SizedBox(
              height: 300,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            product['image'],
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['price'],
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // Promo Section
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.network(
                    'https://cart-verse.netlify.app/assets/banner3-D9-KlIGm.jpg',
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
                      const Text(
                        'Get 20% Off Your First Order!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign up and enjoy exclusive discounts.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        ),
                        child: const Text(
                          'Shop Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],

                  ),
                ),
              ],
            ),

            // Footer Section
            Container(
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
                          children: const [
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
                          children: const [
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
                          children: const [
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
                          children: const [
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

                  const SizedBox(height: 40),

                  // Bottom Row (Copyright)
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Copyright © 2025 Cartverse By Yousra Amr.\nAll Rights Reserved',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
