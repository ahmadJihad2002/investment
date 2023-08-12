import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/firebase_options.dart';
import 'package:investment/modules/home/home.dart';
import 'package:investment/modules/productDetail/productDetail.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getHomeData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (ontext, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: {'ProductDetail': (context) => ProductDetail()},
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
              visualDensity: VisualDensity.adaptivePlatformDensity,

              // useMaterial3: true,
            ),
            home: ProductDetail(),
          );
        },
      ),
    );
  }
}
