import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:investment/shared/components/components.dart';
import 'dart:io';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/cubit.dart';
import 'package:investment/shared/cubit/states.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  TextEditingController place = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController space = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessSendingProductState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text('تم الارسال بنجاح ')));
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                cubit.getHomeData();

                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
               automaticallyImplyLeading: false,

          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          defaultButton(
                              function: () {
                                cubit.getFromGallery();
                              },
                              width: 100,
                              icon: Icons.photo,
                              text: " اختر صورة"),
                          const SizedBox(height: 10),
                          cubit.pickedFile.isEmpty
                              ? const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_not_supported_sharp),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cubit.pickedFile.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.file(
                                            File(cubit.pickedFile[index].path),
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 40,
                            child: defaultFormField(
                              maxLine: 1,
                              controller: price,
                              inputType: TextInputType.number,
                              label: 'السعر/متر',
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "قم بإدخال العنوان بالأول";
                                }
                              },
                            ),
                          ),
                          DropdownButton<String>(
                            value: cubit.selectedCity,
                            onChanged: (newValue) {
                              cubit.setCity(newValue);
                            },
                            items: cubit.westBankCitiesArabic
                                .map<DropdownMenuItem<String>>((String city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: defaultFormField(
                          maxLine: 1,
                          controller: space,
                          inputType: TextInputType.number,
                          label: 'المساحة/متر',
                          validate: (value) {
                            if (value.isEmpty) {
                              return "قم بإدخال المساحة بالأول";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(height: 10),
                      defaultFormField(
                        controller: place,
                        inputType: TextInputType.text,
                        label: 'العوان',
                        icon: Icons.place,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "قم بإدخال العنوان بالأول";
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      defaultFormField(
                        maxLine: null,
                        controller: detail,
                        inputType: TextInputType.multiline,
                        label: 'تفاصيل',
                        icon: Icons.place,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "قم بإدخال العنوان بالأول";
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      ConditionalBuilder(
                        condition: state is AppLoadingSendingProductState,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        fallback: (context) => defaultButton(
                          function: () {
                            cubit.sendDataToFirestore(
                              price: double.parse(price.text),
                              place: place.text,
                              space: double.parse(space.text),
                              classification: detail.text,
                              image: cubit.pickedFile,
                              isTaboo: true,
                            );
                          },
                          icon: Icons.add,
                          text: "إضافة",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
