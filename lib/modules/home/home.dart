import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/modules/productDetail/productDetail.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Card(
                    elevation: 1.0,
                    child: InkWell(
                      onTap: () {
                        AppCubit.get(context)
                            .navigateToNextScreen(context, 'ProductDetail');
                      },
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("المكان "),
                                    Text("الخليل "),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("طابو "),
                                    Text("نعم "),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("مساحة"),
                                    Text(" 200"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
