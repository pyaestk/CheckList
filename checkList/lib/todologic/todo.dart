import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String price;
  String shop;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    required this.id,
    this.price = '',
    this.shop = '',
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    createdTime: json['createdTime'] != null ? DateTimeUtils.toDateTime(json['createdTime'] as Timestamp) ?? DateTime.now() : DateTime.now(),
    title: json['title'],
    description: json['description'],
    shop: json['shop'],
    price: json['price'],
    id: json['id'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': DateTimeUtils.fromDateTimeToJson(createdTime),
    'title': title,
    'description': description,
    'id': id,
    'isDone': isDone,
    'shop':shop,
    'price':price
  };
}

class DateTimeUtils {

  static DateTime? toDateTime(Timestamp value){
    if(value == null) {
      return null;
    }
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if(date == null) {
      return null;
    }
    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
  transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> data,
            EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );
}