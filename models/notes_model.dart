import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesModel {
  int? id;
  String? title;
  String? notes;


  String? date;
  String? time;
  String? category;

  NotesModel({
    this.id,
    required this.title,
    required  this.notes,

    this.time,
    this.date,
    required   this.category,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': notes,

      'date': date?.split('T')[0],// Format date to yyyy-mm-dd
      'time': time,
      'category': category,

    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      notes: map['note'],

      date: map['date'] ,
      category: map['category'],

      time: map['time'],
    );
  }

}
