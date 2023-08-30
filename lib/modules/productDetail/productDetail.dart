import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:investment/models/productModel.dart';
import 'package:investment/shared/components/components.dart';
import 'package:investment/models/productModel.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    height: 300,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    autoPlayCurve: Curves.fastOutSlowIn),
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
                          ));
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'تفاصيل ',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
              Text(
                productModel.classification,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
              defaultButton(function: () {}, text: 'تواصل')
            ],
          ),
        ),
      ),
    );
  }
}
