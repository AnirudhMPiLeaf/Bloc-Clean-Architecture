/// This file manages the route errors.
library error;

class RouteException implements Exception {
  const RouteException(this.message);
  final String message;
}
