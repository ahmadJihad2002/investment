import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

 import 'package:firebase_storage/firebase_storage.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:investment/models/productModel.dart';
 import 'package:investment/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  List<ProductModel?> productsModel = [];

  Future<void> getHomeData() async {
    emit(AppLoadingProductsStates());
    productsModel.clear();

    final querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    // Create a list to hold the futures for each product's image URLs
    if (querySnapshot.docs.isEmpty) {
      emit(AppSuccessProductsStates());
    } else {
      try {
        querySnapshot.docs.forEach((doc) async {
          ProductModel productData =
              await ProductModel.fromJson(doc.data(), docId: doc.id);

          List<Future<String>> imageUrlFutures =
              await productData.image.map((imageName) {
            return getImageUrl(
                imageName); // getImageUrl returns a Future<String>
          }).toList();
          List<String> updatedImageUrls = await Future.wait(imageUrlFutures);
          productData.image
              .replaceRange(0, productData.image.length, updatedImageUrls);

          // Add all the image URL futures to the imageUrlFutures list

          productsModel.add(productData);
          print(productData.image);
          emit(AppSuccessProductsStates());
        });
      } catch (error, stackTrace) {
        emit(AppErrorProductsStates());
        print('Stack Trace: $stackTrace');
        print('Error fetching document from Firestore: $error');
      }

      // Emit the success state here, after all data is loaded

      // emit(AppLoadingProductsStates());
      // productModel.clear();

      // await FirebaseFirestore.instance.collection('products').get().then((value) {
      //   value.docs.forEach((element) async {
      //     ProductModel productData = ProductModel.fromJson(element.data());
      //     // converting image name with image URl
      //     List<Future<String>> imageUrlFutures =
      //         await productData.image.map((imageName) {
      //       return getImageUrl(imageName); // getImageUrl returns a Future<String>
      //     }).toList();
      //     List<String> updatedImageUrls = await Future.wait(imageUrlFutures);
      //     productData.image
      //         .replaceRange(0, productData.image.length, updatedImageUrls);
      //     Future.wait(imageUrlFutures);
      //     productModel.add(productData);
      //   });
      //   // Wait for all the image URL futures to complete before proceeding
      //   // Now, all productModel items are filled with image URLs
      //   print('the test is ');
      //   print(productModel.toString());
      //   emit(AppSuccessProductsStates());
      // }).catchError((error, stackTrace) {
      //   emit(AppErrorProductsStates());
      //   print('Stack Trace: $stackTrace');
      //   print('Error fetching document from Firestore: $error');
      // });

      // Wait for all the image URL futures to complete before proceeding
    }
  }

// try {
//   // Fetch the document data
//   DocumentSnapshot documentSnapshot =
//       await productDocument.doc('products').get();
//
//   if (documentSnapshot.exists) {
//     // Access the data of the document
//     Map<String, dynamic> data =
//         jsonDecode(jsonEncode(documentSnapshot.data()));
//
//     print('Document ID: ${documentSnapshot.id}');
//     print('Document Data: $data');
//     for (int i = 0; i < data['arr'].length; i++) {
//       ProductModel productData = ProductModel.fromJson(data['arr'][i]);
//
//       List<Future<String>> imageUrlFutures =
//           productData.image.map((imageName) {
//         return getImageUrl(
//             imageName); // getImageUrl returns a Future<String>
//       }).toList();
//       List<String> updatedImageUrls = await Future.wait(imageUrlFutures);
//       productData.image
//           .replaceRange(0, productData.image.length, updatedImageUrls);
//
//       productModel.add(productData);
//     }
//     emit(AppSuccessProductsStates());
//   } else {
//     print('Document does not exist');
//   }
// } catch (error, stackTrace) {
//   emit(AppErrorProductsStates());
//   print('Stack Trace: $stackTrace');
//   print('Error fetching document from Firestore: $error');
// }

// getting the image URl By combining image name with the path
  Future<String> getImageUrl(String imageName) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('/pictures/$imageName');

    try {
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (error) {
      print('Error getting image URL: $error');
      return ''; // Return an empty string or handle the error
    }
  }

  String selectedCity = 'دورا';

  void setCity(String? city) {
    selectedCity = city ?? 'دورا';
    emit(AppCitySelectedState());
  }

  bool isTaboo = false;

  void setIsTaboo(bool value) {
    isTaboo = value;
    emit(AppIsTabooChangeState());
  }

  List<String> westBankCitiesArabic = [
    'رام الله',
    'بيت لحم',
    'الخليل',
    'نابلس',
    'أريحا',
    'جنين',
    'طولكرم',
    'قلقيلية',
    'سلفيت',
    'طوباس',
    'بيت ساحور',
    'بيت جالا',
    'البيرة',
    'دورا',
    'يطا',
    'الظاهرية',
    'سبسطية',
    'العبيدية',
  ];

  List<File> pickedFile = [];

  void getFromGallery() async {
    emit(AppImageLoadingStates());

    await ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )
        .then((value) {
      if (value != null) {
        pickedFile.add(File(value.path));
        emit(AppImageSuccessStates());
      }
    }).catchError((error) {
      emit(AppImageErrorStates());
    });
  }

// Function to add data to Firestore
  Future<void> sendDataToFirestore(
      {
      // required int id,
      required double price,
      required List<File> image,
      required String place,
      required bool isTaboo,
      required double space,
      required String classification}) async {
    emit(AppLoadingSendingProductState());
    CollectionReference collection =
        FirebaseFirestore.instance.collection('products');

    Map<String, dynamic> data = {
      // 'id': id,
      'price': price,
      'imagesName': getListOfImagesNamesFromPath(image),
      'place': place,
      'isTaboo': isTaboo,
      'space': space,
      'classification': classification,
    };

    /// uploading the pictures into firebase storage by loop
    for (int i = 0; i < image.length; i++) {
      String imageName = getImageNameFromPath(image[i]);
      await uploadPhotoToStorage(imageFile: image[i], imageName: imageName);
    }

    // Adding data to Firestore database
    await collection.doc().set(data).then((value) {
      pickedFile.clear();
      emit(AppSuccessSendingProductState());
      print('added some shit ');
    }).catchError((error) {
      emit(AppErrorSendingProductState());
      print('error');
      print(error.toString());
    });
  }

  Future<void> deleteProduct(String docID) async {
    emit(ProductDeleteLoadingState());
    CollectionReference collection =
        FirebaseFirestore.instance.collection('products');

    DocumentReference documentRef = collection.doc(docID);
    await documentRef.get().then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        print('data is');
        print(data);
        print(data['imagesName']);
        if (data.containsKey('imagesName')) {
          for (int i = 0; i < data['imagesName'].length; i++) {
            deleteProductPhotos(imageName: data['imagesName'][i].toString());
          }
        } else {
          // "field2" does not exist in the document
          print('Field2 does not exist in the document.');
        }
      } else {
        // Document does not exist
        print('Document does not exist');
      }
    });
    await collection.doc(docID).delete().then((value) {

    }).catchError((error) {
      emit(ProductDeleteErrorState());
    });
  }

// delete the image from  firebase storage
  Future<void> deleteProductPhotos({required String imageName}) async {
    emit(ProductDeletePhotoLoadingState());
print(imageName);
    await FirebaseStorage.instance
        .ref().child("pictures/$imageName")
        .delete()
        .then((value) {
      emit(ProductDeletePhotoSuccessState());
    }).catchError((error) {
      emit(ProductDeletePhotoErrorState(error.toString()));
    });
  }

// Upload photo to Firebase Storage
  Future<void> uploadPhotoToStorage(
      {required File imageFile, required String imageName}) async {
    // emit(AppImageSendLoadingSelectedState());
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pictures/$imageName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    print('csd');
    await uploadTask.whenComplete(() {
      // emit(AppImageSendSuccessSelectedState());
      print('Image uploaded');
    });
  }

  String getImageNameFromPath(File file) {
    String path = file.path;
    // Get the last part of the path, which is the file name
    String imageName = path.split('/').last;
    return imageName;
  }

// return list of images names
  List<String> getListOfImagesNamesFromPath(List<File> file) {
    List<String> imagesNames = [];
    for (int i = 0; i < file.length; i++) {
      String path = file[i].path;
      String imageName = path.split('/').last;
      imagesNames.add(imageName);
    }
    return imagesNames;
  }
}
