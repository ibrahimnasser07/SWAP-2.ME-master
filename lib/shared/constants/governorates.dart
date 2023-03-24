class City {
  final String name;

  City(this.name);
}

class Governorate {
  final String name;
  final List<City> cities;

  Governorate(this.name, this.cities);
}

List<Governorate> governorates = [
  Governorate('الإسكندرية', [
    City('الإسكندرية'),
    City('برج العرب'),
    City('برج العرب الجديدة'),
    City('الحضرة'),
    City('الدخيلة'),
    City('الرمل'),
    City('سموحة'),
    City('اللبان'),
  ]),
  Governorate('القاهرة', [
    City('القاهرة الجديدة'),
    City('مصر الجديدة'),
    City('المقطم'),
    City('الجيزة'),
    City('حلوان'),
    City('الزمالك'),
    City('المعادي'),
    City('المهندسين'),
    City('الدقي'),
    City('العباسية'),
    City('مدينة نصر'),
    City('التجمع الخامس'),
  ]),
  Governorate('الجيزة', [
    City('6 أكتوبر'),
    City('الشيخ زايد'),
    City('العياط'),
    City('البدرشين'),
    City('الصف'),
    City('أطفيح'),
    City('الحوامدية'),
    City('العين السخنة'),
  ]),
  Governorate('الفيوم', [
    City('الفيوم'),
    City('طامية'),
    City('سنورس'),
    City('إطسا'),
    City('إبشواي'),
    City('سيدو'),
  ]),
  Governorate('الأقصر', [
    City('الأقصر'),
    City('الطود'),
    City('البياضية'),
    City('القرنة'),
    City('أرمنت'),
    City('الزينية'),
    City('الشيخ حمادة'),
    City('المنشأة'),
  ]),
  Governorate('الإسماعيلية', [
    City('الإسماعيلية'),
    City('التل الكبير'),
    City('فايد'),
    City('القنطرة شرق'),
    City('القنطرة غرب'),
    City('القصاصين الجديدة'),
  ]),
  Governorate('الغربية', [
    City('طنطا'),
    City('المحلة الكبرى'),
    City('السنطة'),
    City('زفتى'),
    City('السنبلاوين'),
    City('كفر الزيات'),
    City('بسيون'),
    City('سمنود'),
  ]),
];