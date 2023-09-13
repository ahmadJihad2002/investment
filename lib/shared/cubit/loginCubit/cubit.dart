
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/models/adminModel.dart';

import 'package:investment/shared/cubit/loginCubit/states.dart';

import 'package:investment/shared/network/local/cache_helper.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialStates());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({required String email, required password}) async {
    emit(AppLoginLoadingStates());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('the nigga token  is ');
      print(value.user?.uid);
      CacheHelper.saveData(key: 'token', value: value.user?.uid);

      emit(AppLoginSuccessStates());

    }).catchError((error) {
      emit(AppLoginErrorStates(error.toString()));
      print(error.toString());
    });
  }

  late AdminModel adminModel;

  // Future<void> getAdminData({required String uId}) async {
  //   final docSnapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(uId).get();
  //   // Create a list to hold the futures for each product's image URLs
  //   try {
  //     AdminModel.fromJson(docSnapshot.data()!);
  //     phoneNumber = adminModel.phoneNumber!;
  //   } catch (error, stackTrace) {
  //     print('Stack Trace: $stackTrace');
  //     print('Error fetching document from Firestore: $error');
  //   }
  // }

  // Future<void> setAdminData({required String uId}) async {
  //   await FirebaseFirestore.instance.collection('users').doc(uId).update({
  //     'name': "kamal",
  //     'phneNumber': "+972569751749",
  //     'uId': uId,
  //   });
  //   // Create a list to hold the futures for each product's image URLs
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordVisibilityState());
  }
}
