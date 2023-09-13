import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment/models/productModel.dart';

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
                    Text("المدينة ",
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 10),
                    Text(productModel?.place ?? 'لا يوجد'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("السعر/متر ",
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(productModel!.price.toString()),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("المساحة",
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(productModel.space.toString() ?? ''),
                  ],
                ),
              ],
            ),
          ),
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
