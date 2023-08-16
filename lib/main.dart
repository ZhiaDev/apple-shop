import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'di/di.dart';
import 'utility/svg.dart';
import 'gen/assets.gen.dart';
import 'pages/home_page.dart';
import 'constants/colors.dart';
import 'pages/profile_page.dart';
import 'pages/category_page.dart';
import 'pages/checkout_page.dart';
import '/bloc/home/home_bloc.dart';
import '/bloc/home/home_event.dart';
import '/data/model/checkout_item.dart';
import '/bloc/category/category_bloc.dart';
import '/bloc/checkout/checkout_bloc.dart';
import '/bloc/checkout/checkout_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CheckoutItemAdapter());
  await Hive.openBox<CheckoutItem>('CheckoutItemBox');
  await getItInit();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SM',
          useMaterial3: true,
          colorSchemeSeed: Kcolor.primery,
        ),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("fa", "IR"),
        supportedLocales: const [Locale("fa", "IR")],
        home: Scaffold(
          body: IndexedStack(
            index: selectedBottomNavigationIndex,
            children: getPages(),
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: BottomNavigationBar(
                onTap: (int index) {
                  setState(() {
                    selectedBottomNavigationIndex = index;
                  });
                },
                selectedFontSize: 12,
                unselectedFontSize: 12,
                selectedItemColor: Kcolor.primery,
                unselectedItemColor: Kcolor.black,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                currentIndex: selectedBottomNavigationIndex,
                selectedLabelStyle: const TextStyle(fontFamily: 'SB'),
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Ksvg(
                      size: 26,
                      color: Kcolor.black,
                      path: Assets.icons.home,
                    ),
                    label: 'خانه',
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 10),
                            color: Kcolor.primery,
                          )
                        ],
                      ),
                      child: Ksvg(
                        size: 26,
                        color: Kcolor.primery,
                        path: Assets.icons.homeBold,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Ksvg(
                      size: 26,
                      color: Kcolor.black,
                      path: Assets.icons.category,
                    ),
                    label: 'دسته بندی ها',
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 10),
                            color: Kcolor.primery,
                          )
                        ],
                      ),
                      child: Ksvg(
                        size: 26,
                        color: Kcolor.primery,
                        path: Assets.icons.categoryBold,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Ksvg(
                      path: Assets.icons.checkout,
                      size: 26,
                      color: Kcolor.black,
                    ),
                    label: 'سبد خرید',
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 10),
                            color: Kcolor.primery,
                          )
                        ],
                      ),
                      child: Ksvg(
                        size: 26,
                        color: Kcolor.primery,
                        path: Assets.icons.checkoutBold,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Ksvg(
                      size: 26,
                      color: Kcolor.black,
                      path: Assets.icons.profile,
                    ),
                    label: 'پروفایل',
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 10),
                            color: Kcolor.primery,
                          )
                        ],
                      ),
                      child: Ksvg(
                        size: 26,
                        color: Kcolor.primery,
                        path: Assets.icons.profileBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getPages() {
    return [
      BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeGetInitializeData());
          return bloc;
        },
        child: const HomePage(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryPage(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<CheckoutBloc>();
          bloc.add(FetchCheckoutItemListEvent());
          return bloc;
        },
        child: const CheckoutPage(),
      ),
      const ProfilePage(),
    ];
  }
}
