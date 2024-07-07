import 'dart:async';



typedef VoidCallback = void Function();

class DeBouncer {
  final int milliseconds;      // The delay time for debouncing in milliseconds
  VoidCallback? action;        // The action to be executed

  Timer? _timer;               // A Timer instance to manage the debouncing

  DeBouncer({this.milliseconds = 1000});

  run(VoidCallback action) {
    _timer?.cancel();          // Cancel any previous Timer instance
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,                  // Schedule the action after a delay
    );
  }
}


class Throttler {
  final int milliseconds = 1000;      // The delay time for throttling in milliseconds
              // A Timer instance to manage the throttling
  bool _isReady = true;        // Flag to check if the action can be executed

  Throttler();

  void run(VoidCallback action) {
    if (_isReady) {
      action();                // Execute the action immediately
      _isReady = false;        // Set the flag to false indicating action is executed

      Timer(
        Duration(milliseconds: milliseconds),
            () {
          _isReady = true;    // Reset the flag after the delay period
        },
      );
    }
  }
}