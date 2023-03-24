import '../../../model/ads_model.dart';

abstract class SwapStates {}
class SwapInitialState extends SwapStates {}


class GetUserDataLoadingState extends SwapStates {}
class GetUserDataSuccessState extends SwapStates {}
class GetUserDataErrorState extends SwapStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class ShowPasswordState extends SwapStates {}

class ChangeBottomNavBarState extends SwapStates {}

class GetProDataLoadingState extends SwapStates {}

class GetProDataSuccessState extends SwapStates {}

class GetProDataErrorState extends SwapStates {
  final String error;

  GetProDataErrorState(this.error);
}

class GetDataLoadingState extends SwapStates {}

class GetDataSuccessState extends SwapStates {}

class GetDataErrorState extends SwapStates {
  final String error;

  GetDataErrorState(this.error);
}

class GetProductDataLoadingState extends SwapStates {}

class GetProductDataSuccessState extends SwapStates {}

class GetProductDataErrorState extends SwapStates {
  final String error;

  GetProductDataErrorState(this.error);
}

class GetAdsImagePickedSuccessState extends SwapStates {}

class ProfileImagePickedSuccessState extends SwapStates {}

class NoImagePickedErrorState extends SwapStates {}

class CreateAdsLoadingState extends SwapStates {}

class CreateAdsSuccessState extends SwapStates {}

class CreateAdsErrorState extends SwapStates {}

class RemoveAdsImageSuccessState extends SwapStates {}

class UserDataUpdateSuccessState extends SwapStates {}

class UserDataUpdateFailedState extends SwapStates {}

class UserDataUpdateLoading extends SwapStates {}

class SelectedProductsChanged extends SwapStates {}

class WantedSelectedProductsChanged extends SwapStates {}

class DeletedAdSuccessState extends SwapStates {}

class CategoryAdsSuccessState extends SwapStates {}

class ProductsLoadedSuccessState extends SwapStates {}

class CategoryAdsLoadingState extends SwapStates {}

class ProductsLoadingState extends SwapStates {}

class UserAdsRefreshed extends SwapStates {}

class UserAdsLoadingState extends SwapStates {}

class UserAdsLoadedState extends SwapStates {}

class SwapItemSelectedState extends SwapStates {
  final String id;

  SwapItemSelectedState(this.id);
}
