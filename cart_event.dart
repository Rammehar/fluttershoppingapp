import '../../models/user_model.dart';
import 'package:flutter/foundation.dart';

import '../../models/course_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent{
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent{
  final Course course;
  AddToCart({this.course});
  @override
  List<Object> get props =>[course];
  @override
  String toString() => 'AddedToCart { AddedToCart: $course }';
}

class ItemExistedInCart extends CartEvent{
  final Course course;
  ItemExistedInCart({this.course});

  @override
  List<Object> get props =>[course];

  @override
  String toString() => 'ItemExistedInCart { ItemExistedInCart: $course }';
}

class RemoveItemFromCart extends CartEvent{
  final Course course;
  RemoveItemFromCart({this.course});
  @override
  List<Object> get props =>[course];
}