import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'drawer_widget.dart';
import 'footer.dart';

class CategoriesPage extends StatelessWidget {
   CategoriesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> categories = [
    {
      'title': 'category_men'.tr(),
      'image': 'https://res.cloudinary.com/dnka30e3s/image/upload/v1737885895/Cartverse/srsrzcnhyektvc0l5jfr.jpg',
    },
    {
      'title': 'category_women'.tr(),
      'image': 'https://res.cloudinary.com/dnka30e3s/image/upload/v1737885895/Cartverse/tsfuikevxfjqmvqk3qsf.jpg',
    },
    {
      'title': 'category_kids'.tr(),
      'image': 'https://cdn-eu.dynamicyield.com/api/9876644/images/37d243d334c63__hp-w12-22032022-h_m-kids1.jpg',
    },
    {
      'title': 'category_sport'.tr(),
      'image': 'https://cdn-eu.dynamicyield.com/api/9876644/images/1dda9ae79a671__h_m-w40-06102022-7416b-1x1.jpg',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'categories_title'.tr(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              category['image']!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['title']!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
