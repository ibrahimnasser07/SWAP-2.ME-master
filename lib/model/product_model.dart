class ProductModel {
  String name;
  String pId;
  String image;

  ProductModel({
    required this.pId,
    required this.name,
    required this.image,
  });

  ProductModel.fromFireStore(Map<String, dynamic> data)
      : this(
          pId: data['pId'],
          name: data['name'],
          image: data['image'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'pId': pId,
      'image': image,
    };
  }
}
