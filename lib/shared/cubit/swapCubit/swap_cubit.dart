import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_me/model/ads_model.dart';
import 'package:swap_me/model/category_model.dart';
import 'package:swap_me/model/product_model.dart';
import 'package:swap_me/model/user_model.dart';
import 'package:swap_me/screens/HomeScreen/home_screen.dart';
import 'package:swap_me/screens/MyAds/my_ads.dart';
import 'package:swap_me/screens/Notifications/notifications_screen.dart';
import 'package:swap_me/screens/Profile/profile_screen.dart';
import 'package:swap_me/shared/components/toast.dart';
import 'package:swap_me/shared/constants/constants.dart';
import 'package:swap_me/shared/cubit/swapCubit/swap_state.dart';

import '../../../screens/onBoard/on_board_screen.dart';
import '../../components/navigator.dart';
import '../../network/cache_helper.dart';

class SwapCubit extends Cubit<SwapStates> {
  SwapCubit() : super(SwapInitialState());

  static SwapCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    NotificationScreen(),
    MyAdsScreen(),
    MyProfileScreen(),
  ];

  List<String> titles = ['الأقسام', 'تنبهاتى', 'إعلاناتى', 'حسابى'];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 0) {
      getCategoryData();
      getProductData(categoryMainModel?.cId);
      // TODO: here
      // getProData();
    }
    if (index == 1) {
      //TODO: add here
    }
    if (index == 2) {
      getMyAdsData(userModel?.uId);
    }
    if (index == 3) {}
    emit(ChangeBottomNavBarState());
  }

  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromFireStore(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  // TODO: this function is not used
  void showPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }

  List<CategoryMainModel> category = [];

  List<String> cId = [];

  getCategoryData() {
    FirebaseFirestore.instance.collection('categoryMain').get().then((value) {
      category = [];
      for (var element in value.docs) {
        category.add(CategoryMainModel.fromFireStore(element.data()));
        cId.add(element.id);
      }
    });
  }

  List<ProductModel> newProduct = [];

  List<String> proID = [];

  getDataPro() {
    FirebaseFirestore.instance.collectionGroup('product').get().then((value) {
      newProduct = [];
      for (var element in value.docs) {
        newProduct.add(ProductModel.fromFireStore(element.data()));
        proID.add(element.id);
      }
    });
  }

  /// my fix
  List<ProductModel> tradeProducts = [];
  List<ProductModel> wantedTradeProducts = [];

  String? tradeCategory;
  String? tradeProduct;
  String? wantedTradeCategory;
  String? wantedTradeProduct;

  getSelectedProductsData(String cName, {bool wanted = false}) {
    int cIndex = category.indexWhere((e) => e.name == cName);
    FirebaseFirestore.instance
        .collection('categoryMain')
        .doc(cId[cIndex])
        .collection('product')
        .get()
        .then((value) {
      if (wanted) {
        wantedTradeProducts = [];
        for (var element in value.docs) {
          wantedTradeProducts.add(
            ProductModel.fromFireStore(element.data()),
          );
        }
        emit(SelectedProductsChanged());
      } else {
        tradeProducts = [];
        for (var element in value.docs) {
          tradeProducts.add(
            ProductModel.fromFireStore(element.data()),
          );
        }
        emit(WantedSelectedProductsChanged());
      }
    });
  }

  void resetAddProductsPageValues() {
    tradeProducts = [];
    wantedTradeProducts = [];
    tradeCategory = null;
    tradeProduct = null;
    wantedTradeCategory = null;
    wantedTradeProduct = null;
  }

  /// end my fix
  String selectedId = "None";

  void updateSelectedId(String id) {
    selectedId = id;
    emit(SwapItemSelectedState(selectedId));
  }

  void resetSelectedId() => updateSelectedId("None");

  List<ProductModel> productsList = [];
  List<String> pId = [];

  getProductData(String? cId) {
    emit(ProductsLoadingState());
    productsList = [];
    FirebaseFirestore.instance
        .collection('categoryMain')
        .doc(cId)
        .collection('product')
        .get()
        .then((value) {
      for (var element in value.docs) {
        productsList.add(ProductModel.fromFireStore(element.data()));
        pId.add(element.id);
      }
      emit(ProductsLoadedSuccessState());
    });
  }

  CategoryMainModel? categoryMainModel;

  // TODO: this function is not used
  void getData(String? cId) {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance
        .collection('categoryMain')
        .doc(cId)
        .get()
        .then((value) {
      categoryMainModel = CategoryMainModel.fromFireStore(value.data()!);
      emit(GetDataSuccessState());
      if (kDebugMode) {
        print(value.data());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetDataErrorState(error.toString()));
    });
  }

  List<AdsModel> ads = [];
  List<String> iD = [];

  // naming convention is really bad
  getAdsData() async {
    FirebaseFirestore.instance.collection('ADS').get().then((value) {
      ads = [];
      for (var element in value.docs) {
        ads.add(AdsModel.fromFireStore(element.data()));
        iD.add(element.id);
      }
    });
  }

  List<AdsModel> categoryAdsList = [];
  List<String> id = [];

  // naming convention is really bad
  getADSData(String? pID) async {
    emit(CategoryAdsLoadingState());
    categoryAdsList = [];
    FirebaseFirestore.instance
        .collection('ADS')
        .where('categoryName', isEqualTo: pID)
        .get()
        .then((value) {
      for (var element in value.docs) {
        categoryAdsList.add(AdsModel.fromFireStore(element.data()));
        id.add(element.id);
      }
      emit(CategoryAdsSuccessState());
    });
  }

  List<AdsModel> userAds = [];

  // naming convention is really bad
  Future<void> getMyAdsData(String? userID) async {
    emit(UserAdsLoadingState());
    FirebaseFirestore.instance
        .collection('ADS')
        .where("iD", isEqualTo: userID)
        .get()
        .then((value) {
      userAds = [];
      for (var element in value.docs) {
        userAds.add(AdsModel.fromFireStore(element.data()));
      }
      emit(UserAdsLoadedState());
    });
  }

  var picker = ImagePicker();

  File? adsImagePicked;
  File? profileImagePicked;

  Future<void> pickImage({bool profile = false}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (!profile) {
        adsImagePicked = File(pickedFile.path);
        emit(GetAdsImagePickedSuccessState());
      } else {
        profileImagePicked = File(pickedFile.path);
        emit(ProfileImagePickedSuccessState());
      }
    } else {
      debugPrint('No image selected');
      emit(NoImagePickedErrorState());
    }
  }

  AdsModel? adsModel;

  void getADsData() {
    emit(GetProductDataLoadingState());
    FirebaseFirestore.instance
        .collection('ADS')
        .doc('kBVi65DB1EfFAYCuADgu')
        .get()
        .then((value) {
      adsModel = AdsModel.fromFireStore(value.data()!);
      emit(GetProductDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetProductDataErrorState(error.toString()));
    });
  }

  Future<void> uploadAdsImage({
    required String name,
    String? image,
    String? iD,
    required String desc,
    required dynamic categoryName,
    required dynamic productName,
    required String dateTime,
  }) async {
    emit(CreateAdsLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('adsImage/${Uri.file(adsImagePicked!.path).pathSegments.last}')
        .putFile(adsImagePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createAds(
          iD: userModel!.uId,
          name: name,
          image: value,
          desc: desc,
          categoryName: categoryName,
          productName: productName,
          dateTime: dateTime,
        );
      }).catchError((error) {
        emit(CreateAdsErrorState());
      });
    }).catchError((error) {
      emit(CreateAdsErrorState());
    });
  }

  Future<void> updateAd(AdsModel adsModel) async {
    emit(CreateAdsLoadingState());
    if(adsImagePicked != null){
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('adsImage/${Uri.file(adsImagePicked!.path).pathSegments.last}')
          .putFile(adsImagePicked!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          var docRef = FirebaseFirestore.instance
              .collection("ADS")
              .where("image", isEqualTo: adsModel.image);
          adsModel.image = value;
          docRef.get().then((querySnapshot) async {
            for(var doc in querySnapshot.docs){
              await doc.reference.update(adsModel.toFireStore());
            }
            emit(CreateAdsSuccessState());
          });
        });
      });
    } else {
      var docRef = FirebaseFirestore.instance
          .collection("ADS")
          .where("image", isEqualTo: adsModel.image);
      docRef.get().then((querySnapshot) async {
        for(var doc in querySnapshot.docs){
          await doc.reference.update(adsModel.toFireStore());
        }
        await getMyAdsData(adsModel.iD);
        emit(CreateAdsSuccessState());
      });
    }

  }

  void createAds({
    required String name,
    String? image,
    String? iD,
    required String desc,
    required String categoryName,
    required String productName,
    required String dateTime,
  }) {
    emit(CreateAdsLoadingState());

    AdsModel model = AdsModel(
      iD: userModel!.uId,
      image: image ?? "",
      name: name,
      desc: desc,
      categoryName: categoryName,
      productName: productName,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('ADS')
        .add(model.toFireStore())
        .then((value) {
      emit(CreateAdsSuccessState());
      getMyAdsData(uId);
    }).catchError((error) {
      emit(CreateAdsErrorState());
    });
  }

  void removePostImage() {
    adsImagePicked = null;
    profileImagePicked = null;
    emit(RemoveAdsImageSuccessState());
  }

  void logOut(context) {
    CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      if (value) {
        navigateAndFinish(context, routeName: OnBoardingScreen.routeName);
        FirebaseAuth.instance.signOut();
        changeBottomNav(0);
      }
    });
  }

  void deleteUser(BuildContext context, String password) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    try {
      user!.delete().then((value) {
        navigateAndFinish(
          context,
          routeName: OnBoardingScreen.routeName,
        );
        changeBottomNav(0);
        FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to delete user: $e');
      }
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    emit(UserDataUpdateLoading());
    FirebaseStorage storage = FirebaseStorage.instance;
    var userRef = FirebaseFirestore.instance.collection('users').doc(uId);

    if (profileImagePicked != null) {
      try {
        String imagePath = Uri.file(profileImagePicked!.path).pathSegments.last;
        var taskSnapshot = await storage
            .ref()
            .child('usersProfileImages/$imagePath')
            .putFile(profileImagePicked!);
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        userModel.image = downloadURL;
      } catch (error) {
        showToast(text: error.toString(), state: ToastStates.error);
        emit(UserDataUpdateFailedState());
        return;
      }
      profileImagePicked = null;
    }

    try {
      await userRef.update(userModel.toFireStore());
      showToast(
        text: "تم تحديث معلوماتك بنجاح",
        state: ToastStates.success,
      );
      emit(UserDataUpdateSuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.error);
      emit(UserDataUpdateFailedState());
    }
  }

  Future<String> getAddress(String id) async {
    var userRef = FirebaseFirestore.instance.collection('users').doc(id);
    var userDoc = await userRef.get();
    var userModel = UserModel.fromFireStore(userDoc.data()!);

    if (userModel.governorate != null && userModel.city != null) {
      if (userModel.governorate!.isNotEmpty && userModel.city!.isNotEmpty) {
        return '${userModel.governorate}, ${userModel.city}';
      } else if (userModel.governorate!.isNotEmpty) {
        return userModel.governorate!;
      } else if (userModel.city!.isNotEmpty) {
        return userModel.city!;
      }
    }
    return 'مصر, القاهرة';
  }

  Future<String> getImage(String id) async {
    var userRef = FirebaseFirestore.instance.collection('users').doc(id);
    var userDoc = await userRef.get();
    var userModel = UserModel.fromFireStore(userDoc.data()!);
    return userModel.image;
  }

  Future<String> getName(String id) async {
    var userRef = FirebaseFirestore.instance.collection('users').doc(id);
    var userDoc = await userRef.get();
    var userModel = UserModel.fromFireStore(userDoc.data()!);
    return "${userModel.firstName} ${userModel.lastName}";
  }

  Future<String> getPhone(String id) async {
    var userRef = FirebaseFirestore.instance.collection('users').doc(id);
    var userDoc = await userRef.get();
    var userModel = UserModel.fromFireStore(userDoc.data()!);
    return userModel.phone;
  }

  Future<void> deleteAd({required String image}) async {
    var docRef = FirebaseFirestore.instance
        .collection("ADS")
        .where("image", isEqualTo: image);
    docRef.get().then((querySnapshot) async {
      for(var doc in querySnapshot.docs){
        await doc.reference.delete();
        emit(DeletedAdSuccessState());
      }
    });
  }
}
