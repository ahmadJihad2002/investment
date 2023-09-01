import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordVisibilityState());
  }}
