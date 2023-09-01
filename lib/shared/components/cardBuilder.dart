import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment/models/productModel.dart';

// class CardBuilder extends StatelessWidget {
//   const CardBuilder({Key? key, required this.img}) : super(key: key);
//
//   final String img;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Text('nigga'),
//         ],
//       ),
//     );
//   }
// }

Widget cardBuilder(
    {required BuildContext context, required ProductModel? productModel}) {
  return InkWell(
    onTap: () {
      print('tapped');
      Navigator.pushNamed(context, 'ProductDetail', arguments: productModel);
      // AppCubit.get(context)
      //     .navigateToNextScreen(context, 'ProductDetail');
    },
    child: Card(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                height: 300,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn),
            items: productModel?.image.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: i,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ));
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("المكان "),
                    Text(productModel?.place ?? 'لا يوجد'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("طابو "),
                    Text(productModel!.isTaboo ? 'يوجد' : 'لا يوجد'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("مساحة"),
                    Text(productModel?.space.toString() ?? ''),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
  }

  return color;
}
