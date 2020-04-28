import 'package:bloc/bloc.dart';
import 'package:bmplcourses/models/course_model.dart';
import 'package:bmplcourses/models/user_model.dart';
import '../../repositories/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import './cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;
  User user;

  CartBloc({@required this.cartRepository, @required this.user})
      : assert(cartRepository != null),
        assert(user != null);

  @override
  CartState get initialState => CartLoadingInProgress();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield* _mapCartLoadToState(user);
    }
    if (event is AddToCart) {
      yield* _mapAddCourseToState(event);
    }
  }

  Stream<CartState> _mapAddCourseToState(AddToCart event) async* {
    final currentState = state;

    if (currentState is CartLoadedSuccess) {
      try {
        List<Course> updatedList = List.from(currentState.courses)
          ..add(event.course);
        await cartRepository.addCourseToCart(event.course);
        yield CartLoadedSuccess(updatedList);
        await cartRepository.addCourseToCart(event.course);

      } catch (err) {
        yield CartError(errorMessage: err);
      }
    }
  }

  Stream<CartState> _mapCartLoadToState(user) async* {
    try {
      final cartItems = await cartRepository.fetchCartItems(user);
      yield CartLoadedSuccess(cartItems);
    } catch (err) {
      yield CartError(errorMessage: err);
    }
  }

}
