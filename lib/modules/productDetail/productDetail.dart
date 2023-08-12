import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:investment/shared/components/components.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
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
              items: [
                Container(
                  child: Image.network(
                    'https://img.hulu.com/user/v3/artwork/f5d4278b-6acb-4a63-a7a2-eab91de2611e?base_image_bucket_name=image_manager&base_image=8da09647-76da-4251-ac98-4781f5f5b29a&size=550x825&format=jpeg',
                    fit: BoxFit.fitWidth,
                  ),
                  width: double.infinity,
                ),
                // CachedNetworkImage(
                //   fit: BoxFit.fill,
                //   imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.hulu.com%2Fhub%2Fanime&psig=AOvVaw3ai4gNyQor5GV7jbe21NU5&ust=1691866806865000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMCKl5Kl1YADFQAAAAAdAAAAABAL' ,
                //   // placeholder: (context, url) =>
                //   // const Center(child: CircularProgressIndicator()),
                //   // errorWidget: (context, url, error) =>
                //   // const Icon(Icons.error),
                // )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'تفاصيل ',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
            defaultButton(function: null, text:'' )
          ],
        ),
      ),
    );
  }
}
