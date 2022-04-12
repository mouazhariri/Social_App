class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  //named constructor

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    //because this object is {LIST}

    json['banners'].forEach((element) {
      banners?.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products?.add(ProductModel.fromJson(element));
    });
  }
}

//for carousel slider
class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    image = json['image'] ?? '';
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] ?? '';
    oldPrice = json['old_price'] ?? '';
    discount = json['discount'] ?? '';
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    inFavorites = json['in_favorites'] ?? '';
    inCart = json['in_cart'] ?? '';
  }
}
///////
