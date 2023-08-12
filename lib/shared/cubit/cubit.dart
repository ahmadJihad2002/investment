import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/models/productModel.dart';
import 'package:investment/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  Function navigateToNextScreen(BuildContext context, String screen) {
    // Perform navigation here
    return () => Navigator.pushNamed(context,screen );
  }

  late ProductModel productModel;

  void getHomeData() {}

//
//
// HomeModel? homeModel;
//
// void getHomeData() {
//   DioHelper.getData(url: HOME, token: token).then((value) {
//     homeModel = HomeModel.formJson(value.data);
//     emit(ShopSuccessHomeDataStates());
//   }).catchError((error) {
//     print(error.toString());
//     emit(ShopErrorHomeDataStates());
//   });
//   emit(ShopLoadingHomeDataStates());
// }
//
//
}
