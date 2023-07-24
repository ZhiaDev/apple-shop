import 'package:flutter/material.dart';

import '/constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 42,
              margin: const EdgeInsets.fromLTRB(42, 4, 42, 32),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(),
                  const Text(
                    'حساب کاربری',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SB',
                      color: Kcolor.primery,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Ksvg(
                        path: Assets.icons.apple,
                        size: 28,
                        color: Kcolor.primery,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'پارسا شریفی',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SB',
                color: Kcolor.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '09123456789',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'SM',
                color: Kcolor.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Wrap(
                runSpacing: 18,
                spacing: 14,
                children: [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اپل شاپ',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'SM',
                    color: Kcolor.grey,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '0.0.1',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'GM',
                    color: Kcolor.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'ArioApp.com ©',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GM',
                color: Kcolor.grey,
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
