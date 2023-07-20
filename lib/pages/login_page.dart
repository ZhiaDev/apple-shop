import 'package:flutter/material.dart';

import '../data/repository/authentication_repository.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';
import '/constants/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.primery,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Ksvg(
                    path: Assets.icons.apple,
                    color: Kcolor.white,
                    size: 100,
                  ),
                  const Text(
                    'اپل شاپ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SB',
                      color: Kcolor.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: MediaQuery.of(context).viewInsets.bottom.toInt(),
              child: Container(
                padding: const EdgeInsets.all(16),
                // margin: EdgeInsets.only(
                //   bottom: MediaQuery.of(context).viewInsets.bottom,
                // ),
                // margin: const EdgeInsets.symmetric(horizontal: 4),
                // padding: EdgeInsets.only(
                //   bottom: MediaQuery.of(context).viewInsets.bottom,
                //   top: 16,
                //   right: 16,
                //   left: 16,
                // ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Kcolor.white,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 4,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Kcolor.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(365),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        TextField(
                          controller: _usernameTextController,
                          autocorrect: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text('نام کاربری'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Kcolor.grey,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Kcolor.primery,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            label: const Text('گذرواژه'),
                            contentPadding: const EdgeInsets.all(14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Kcolor.grey,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Kcolor.primery,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            var either = await AuthenticationRepository().login(
                              'users81895',
                              '12345678',
                            );
                            // either.fold(
                            //   (errorMessage) => print(errorMessage),
                            //   (successMessage) => print(successMessage),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Kcolor.primery,
                              foregroundColor: Kcolor.grey2),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ورود به حساب کاربری',
                                style: TextStyle(
                                  color: Kcolor.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              RotatedBox(
                                quarterTurns: 90,
                                child: Icon(Icons.login),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
