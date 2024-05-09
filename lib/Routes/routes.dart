import 'dart:html' as html;

class RouteNavigation {
  void navigateToRoute(String route) {
    html.window.history.pushState(null, '', route);
  }
}
