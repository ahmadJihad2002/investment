import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:investment/models/productModel.dart';
import 'package:investment/shared/components/cardBuilder.dart';
import 'package:investment/shared/components/components.dart';
import 'package:investment/models/productModel.dart';
import 'package:investment/shared/components/constanse.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/shared/network/local/util.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    final ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is ProductDeletePhotoSuccessState) {
          await cubit.getHomeData();
          showToast(state: ToastStates.success, text: 'تم الحذف بنجاح');
          Navigator.pop(context);
        }
        if (state is ProductDeletePhotoErrorState) {
          showToast(state: ToastStates.error, text: state.error);
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  cubit.deleteProduct(productModel.docId);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 300,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: productModel.image.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: i,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue, // Customize the color
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'المكان: ${productModel.place}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.green, // Customize the color
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'السعر/متر: ${productModel.price} دينار',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'التفاصيل',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                  Text(
                    productModel.classification,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  // Add some space between widgets

                  const SizedBox(height: 20),
                  // Add some space between widgets
                  defaultButton(
                    icon: FontAwesome.whatsapp,
                    function: () {
                      // Trigger WhatsApp with the message
                      Util.whatsapp(
                        phoneNumber: phoneNumber,
                        message: ' مرحبا... مهتم في هذا العقار',
                      );
                    },
                    text: 'تواصل',
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
