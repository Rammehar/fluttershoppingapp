import 'package:bmplcourses/blocs/authentication/authentication.dart';
import 'package:bmplcourses/blocs/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Inside MyCartIconButtonBuild");
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState is CartLoadedSuccess) {
                if (cartState.itemsLength > 0) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          top: 7,
                          child: CircleAvatar(
                            radius: 8,
                            child: Text(
                              '${cartState.itemsLength}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          )),
                    ],
                  );
                }
              }
              return IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                ),
              );
            },
          );
        }
        return FlatButton(
          onPressed: () {},
          child: Text(
            "SIGN IN",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
