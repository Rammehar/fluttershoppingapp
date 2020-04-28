import '../../models/course_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartLoadingInProgress extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedSuccess extends CartState {
  final List<Course> courses;


  CartLoadedSuccess([this.courses]);
  int get itemsLength => courses.length;
  @override
  List<Object> get props => [courses];
}

class ItemExistsInCart extends CartState {
  @override
  List<Object> get props => [];
}

class CartError extends CartState {
  final String errorMessage;

  CartError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'CartError { ErrorMsg: $errorMessage }';
}
