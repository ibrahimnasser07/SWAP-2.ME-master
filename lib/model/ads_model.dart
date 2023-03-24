class AdsModel {
  String name;
  String iD;
  String image;
  String desc;
  dynamic categoryName;
  dynamic productName;
  String dateTime;

  AdsModel({
    this.iD = '',
    required this.name,
    required this.image,
    required this.desc,
    required this.categoryName,
    required this.productName,
    required this.dateTime,
  });

  AdsModel.fromFireStore(Map<String, dynamic> data)
      : this(
    iD: data['iD'],
          name: data['name'],
          image: data['image'],
          desc: data['desc'],
          categoryName: data['categoryName'],
          productName: data['productName'],
          dateTime: data['dateTime'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'iD': iD,
      'image': image,
      'desc': desc,
      'categoryName': categoryName,
      'productName': productName,
      'dateTime': dateTime,
    };
  }
}
