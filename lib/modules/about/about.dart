import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('من نحن '),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment:MainAxisAlignment.,
          children: [
            Text(
              'معلومات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'تم تطوير هذا التطبيق  لتسهيل وتسريع عملية تصفح واختيار الأراضي والعقارات المناسبة'
              ' للإهتمام، سواء لأغراض استثمارية أو سكنية.للمساهمة في تسهيل تجربة البحث عن العقارات وتوفير وقت وجهد للمشترين'
              ' والمستثمرين، ولتقديم وسيلة فعّالة لعرض وترويج الأراضي للبيع للوكلاء وأصحاب الممتلكات. ',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مبرمج التطبيق:  م.أحمد جهاد درابيع',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SocialMediaLink(
                  icon: Icons.email,
                  label: 'Email',
                  link: 'john.doe@example.com',
                ),
                SocialMediaLink(
                  icon: Icons.phone,
                  label: 'Phone',
                  link: '+970569751749',
                ),
                SocialMediaLink(
                  icon: Icons.link,
                  label: 'Website',
                  link: 'https://www.johndoe.com',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String link;

  const SocialMediaLink({
    required this.icon,
    required this.label,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // Handle link opening here
          },
          child: Text(label),
        ),
      ],
    );
  }
}
