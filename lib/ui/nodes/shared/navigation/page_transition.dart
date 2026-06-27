import 'package:flutter/material.dart';

enum PageTransitionType { standard, fade, slide }

/// Switch this to compare transition styles across the whole app.
const pageTransitionType = PageTransitionType.standard;

const _transitionDuration = Duration(milliseconds: 300);

Route<T> buildPageRoute<T>(WidgetBuilder builder) {
  PageRouteBuilder<T>? routeRef;

  final route = PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionDuration: _transitionDuration,
    reverseTransitionDuration: _transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (pageTransitionType) {
        case PageTransitionType.standard:
          return Theme.of(context).pageTransitionsTheme.buildTransitions<T>(
            routeRef!,
            context,
            animation,
            secondaryAnimation,
            child,
          );
        case PageTransitionType.fade:
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(opacity: curvedAnimation, child: child);
        case PageTransitionType.slide:
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation);
          return SlideTransition(position: offsetAnimation, child: child);
      }
    },
  );

  routeRef = route;
  return route;
}
