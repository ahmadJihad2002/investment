import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment/shared/components/cardBuilder.dart';

import 'package:investment/shared/components/components.dart';
import 'dart:io';
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
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is AppSuccessSendingProductState) {
          await cubit.getHomeData();
          Navigator.pop(context);
          showToast(state: ToastStates.success, text: 'تمن الاضافة بنجاح');
        } else if (state is AppErrorSendingProductState) {
          showToast(state: ToastStates.error, text: 'حصل خطأ ما ');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                cubit.getHomeData();
                Navigator.pop(context);
                cubit.pickedFile.clear();
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 50,
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
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 200,
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      defaultFormField(
                        controller: place,
                        inputType: TextInputType.text,
                        label: 'العنوان',
                        icon: Icons.place,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "قم بإدخال العنوان بالأول";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      defaultFormField(
                        maxLine: null,
                        controller: detail,
                        inputType: TextInputType.multiline,
                        label: 'التفاصيل',
                        icon: Icons.info,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "قم بإدخال العنوان بالأول";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ConditionalBuilder(
                          condition: state is AppLoadingSendingProductState,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          fallback: (context) => defaultButton(
                            function: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                cubit.sendDataToFirestore(
                                  price: double.parse(price.text),
                                  place: cubit.selectedCity,
                                  space: double.parse(space.text),
                                  classification: detail.text,
                                  image: cubit.pickedFile,
                                  isTaboo: true,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('قم بتعبأة النموذج')));
                              }
                            },
                            icon: Icons.add,
                            text: "إضافة",
                          ),
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
