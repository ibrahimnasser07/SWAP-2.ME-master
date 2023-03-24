import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String? uId = '';

// TODO: constants ??????

String getOs() {
  return Platform.operatingSystem;
}

String daysBetween(DateTime postDate) {
  if ((DateTime.now().difference(postDate).inHours / 24).round() == 0) {
    if (DateTime.now().difference(postDate).inHours == 0) {
      if (DateTime.now().difference(postDate).inMinutes == 0) {
        return 'الان';
      } else {
        return '${DateTime.now().difference(postDate).inMinutes.toString()} دقائق ';
      }
    } else {
      return '${DateTime.now().difference(postDate).inHours.toString()} ساعات ';
    }
  } else {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} ايام ');
  }
}

String getDate() {
  DateTime dateTime = DateTime.now();
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

String getNowDateTime(Timestamp dateTime) {
  String date = DateFormat.yMd().format(dateTime.toDate()).toString();
  String time = DateFormat.Hm().format(dateTime.toDate()).toString();
  List<String> nowSeparated = [date, time];
  String nowJoined = nowSeparated.join(' at ');
  return nowJoined;
}

String time = DateTime.now().toString().split(' ').elementAt(1);
