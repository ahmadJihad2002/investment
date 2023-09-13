import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/models/productModel.dart';
import 'package:investment/modules/productDetail/productDetail.dart';
import 'package:investment/shared/components/cardBuilder.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.pushNamed(context, 'about'),
                        icon: const Icon(Icons.question_mark_sharp))
                  ],
                  leading: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, 'dashboard'),
                      icon: const Icon(Icons.add))),
              body: (cubit.productsModel.isEmpty &&
                      state is! AppLoadingProductsStates)
                  ? Center(
                      child: Text('لا يوجد عقارات ',
                          style: Theme.of(context).textTheme.displaySmall),
                    )
                  : ConditionalBuilder(
                      builder: (context) =>
                          productBuilder(productModel: cubit.productsModel),
                      condition: state is AppSuccessProductsStates,
                      fallback: (BuildContext context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    )),
        );
      },
    );
  }

  Widget productBuilder({required List<ProductModel?> productModel}) {
    return ListView.builder(
        itemCount: productModel.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return cardBuilder(
              context: context, productModel: productModel[index]);
        });
  }
}
