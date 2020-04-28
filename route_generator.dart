import 'package:bmplcourses/blocs/cart/cart.dart';
import 'package:bmplcourses/blocs/login/login_bloc.dart';
import 'package:bmplcourses/common/common.dart';
import 'package:bmplcourses/repositories/cart_repository.dart';
import 'package:bmplcourses/screens/home/home_screen.dart';
import 'package:bmplcourses/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';
import 'blocs/course_sections/course_sections.dart';
import 'blocs/intro/intro.dart';

import 'repositories/intro_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/section_repository.dart';

import 'screens/course_detail/course_detail_screen.dart';
import 'screens/course_sections/course_sections_screen.dart';
import 'screens/intro/intro_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<CartBloc>(
                      create: (context) => CartBloc(
                          user: state.user, cartRepository: CartRepository())
                        ..add(
                          LoadCart(),
                        ),
                    ),
                  ],
                  child: HomeScreen(user: state.user),
                );
              }
              if (state is Unauthenticated) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<IntroBloc>(
                      create: (context) =>
                          IntroBloc(introRepository: IntroRepository())
                            ..add(GetIntro()),
                    ),
                  ],
                  child: IntroScreen(),
                );
              }
              return LoadingIndicator();
            },
          );
        });
      case '/browse':
        return MaterialPageRoute(builder: (_) {
          return HomeScreen();
        });

      case '/signin':
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                  userRepository: UserRepository(),
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context),
                ),
              ),
            ],
            child: LoginScreen(),
          );
        });
      case '/course-sections':
        var courseId = settings.arguments;
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CourseSectionsBloc>(
                create: (context) => CourseSectionsBloc(
                    myCourseId: courseId,
                    sectionsRepository: SectionsRepository())
                  ..add(GetCourseSections()),
              ),
            ],
            child: CourseSectionsScreen(),
          );
        });

      case '/course-detail':
        var courseId = settings.arguments;
        return MaterialPageRoute(builder: (_) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<CourseSectionsBloc>(
                      create: (context) => CourseSectionsBloc(
                          myCourseId: courseId,
                          sectionsRepository: SectionsRepository())
                        ..add(GetCourseSections()),
                    ),
                    BlocProvider<CartBloc>(
                      create: (context) => CartBloc(
                          user: state.user, cartRepository: CartRepository())
                        ..add(
                          LoadCart(),
                        ),
                    ),
                  ],
                  child: CourseDetailScreen(),
                );
              }
              return MultiBlocProvider(
                providers: [
                  BlocProvider<CourseSectionsBloc>(
                    create: (context) => CourseSectionsBloc(
                        myCourseId: courseId,
                        sectionsRepository: SectionsRepository())
                      ..add(GetCourseSections()),
                  ),
                ],
                child: CourseDetailScreen(),
              );
            },
          );
        });
      default:
        return _errorHandlingRoute();
    }
  }

  static Route<dynamic> _errorHandlingRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error Page"),
        ),
        body: Center(
          child: Text("Error: Opps Something went Wrong!"),
        ),
      );
    });
  }
}
