import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utility/svg.dart';
import '../gen/assets.gen.dart';
import '/constants/colors.dart';
import '/bloc/authentication/auth_bloc.dart';
import '/bloc/authentication/auth_event.dart';
import '/bloc/authentication/auth_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameTextController = TextEditingController(text: 'users81895');
  final _passwordTextController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.primery,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ksvg(
                  path: Assets.icons.apple,
                  color: Kcolor.white,
                  size: 128,
                ),
                const Text(
                  'اپل شاپ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'SB',
                    color: Kcolor.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 4,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Kcolor.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(365),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 12),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'برای ورود مشخصات زیر را وارد کنید',
                            style: TextStyle(
                              color: Kcolor.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
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
                        const SizedBox(height: 18),
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
                        const SizedBox(height: 18),
                        loginButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LoginButton different states
  BlocBuilder<AuthBloc, AuthState> loginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitiateState) {
          return ElevatedButton(
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(
                AuthLoginRequest(
                  _usernameTextController.text,
                  _passwordTextController.text,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Kcolor.grey2,
              backgroundColor: Kcolor.primery,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ورود به حساب کاربری',
                  style: TextStyle(
                    fontSize: 16,
                    color: Kcolor.white,
                  ),
                ),
                SizedBox(width: 8),
                RotatedBox(
                  quarterTurns: 90,
                  child: Icon(Icons.login, size: 24),
                )
              ],
            ),
          );
        } else if (state is AuthLoadingState) {
          return ElevatedButton(
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(
                AuthLoginRequest(
                  _usernameTextController.text,
                  _passwordTextController.text,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Kcolor.grey2,
              backgroundColor: Kcolor.primery,
            ),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Kcolor.white,
                      ),
                    )
                  ],
                ),
                Opacity(
                  opacity: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ورود به حساب کاربری',
                        style: TextStyle(
                          fontSize: 16,
                          color: Kcolor.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      RotatedBox(
                        quarterTurns: 90,
                        child: Icon(Icons.login, size: 24),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is AuthResponseState) {
          return state.response.fold(
            (l) => Text(l, textDirection: TextDirection.ltr),
            (r) => Text(r),
          );
        }
        return const Text('خطای نامشخص!');
      },
    );
  }
}
