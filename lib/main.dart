import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/modules/about/about.dart';
import 'package:investment/modules/dashBoard/dashboard.dart';
import 'package:investment/modules/home/home.dart';
import 'package:investment/modules/login/login.dart';
import 'package:investment/modules/productDetail/productDetail.dart';
import 'package:investment/shared/components/constanse.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/loginCubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';
import 'package:investment/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  token = await CacheHelper.getData(key: 'token');
  if (token.isEmpty) {
    widget = Login();
  } else {
    widget = Home();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getHomeData()),
        BlocProvider(create: (BuildContext context) => AppLoginCubit())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (ontext, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: {
              'ProductDetail': (context) => ProductDetail(),
              'home': (context) => Home(),
              'dashboard': (context) => DashBoard(),
              'about': (context) => About(),
            },
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
              visualDensity: VisualDensity.adaptivePlatformDensity,

              // useMaterial3: true,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
