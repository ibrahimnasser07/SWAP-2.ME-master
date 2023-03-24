import 'package:swap_me/model/ads_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/model/product_model.dart';

class ScreenArgs {
  ProductModel? productModel;
  CategoryMainModel categoryMainModel;
  AdsModel adsModel;

  ScreenArgs({
    required this.adsModel,
    this.productModel,
    required this.categoryMainModel,
  });
}
