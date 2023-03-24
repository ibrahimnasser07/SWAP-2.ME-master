class CategoryMainModel {
  String name;
  String cId;
  String image;
  
  CategoryMainModel({
    required this.cId,
    required this.name,
    required this.image,
  });

  CategoryMainModel.fromFireStore(Map<String, dynamic> data)
      : this(
          cId: data['cId'],
          name: data['name'],
          image: data['image'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'cId': cId,
      'image': image,
    };
  }
}
