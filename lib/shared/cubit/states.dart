abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppLoadingProductsStates extends AppStates {}

class AppSuccessProductsStates extends AppStates {}

class AppErrorProductsStates extends AppStates {}

class AppImageLoadingStates extends AppStates {}

class AppImageSuccessStates extends AppStates {}

class AppImageErrorStates extends AppStates {}

class AppCitySelectedState extends AppStates {}

class AppImageSendLoadingSelectedState extends AppStates {}

class AppImageSendSuccessSelectedState extends AppStates {}

class AppImageSendErrorSelectedState extends AppStates {}

class AppLoadingSendingProductState extends AppStates {}

class AppSuccessSendingProductState extends AppStates {}

class AppErrorSendingProductState extends AppStates {}

class AppIsTabooChangeState extends AppStates {}

class ProductDeleteSuccessState extends AppStates {}

class ProductDeleteErrorState extends AppStates {}

class ProductDeleteLoadingState extends AppStates {}

class ProductDeletePhotoLoadingState extends AppStates {}

class ProductDeletePhotoSuccessState extends AppStates {}

class ProductDeletePhotoErrorState extends AppStates {
  String error;

  ProductDeletePhotoErrorState(this.error);
}
