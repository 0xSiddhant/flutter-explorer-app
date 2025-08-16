import 'dart:isolate';
import 'dart:math';

/// Fibonacci calculations using isolate
class FibonacciCalculator {
  FibonacciCalculator._();

  /// Calculate Fibonacci in UI thread (blocks UI)
  static Future<int> calculateInUIThread(int n) async {
    return _fibonacci(n);
  }

  /// Calculate Fibonacci using isolate (non-blocking)
  static Future<int> calculateInIsolate(int n) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_fibonacciIsolate, [receivePort.sendPort, n]);
    return await receivePort.first as int;
  }

  static void _fibonacciIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final n = args[1] as int;
    sendPort.send(_fibonacci(n));
  }

  /// Iterative Fibonacci implementation
  static int _fibonacci(int n) {
    if (n <= 1) return n;

    int a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
      int temp = a + b;
      a = b;
      b = temp;
    }
    return b;
  }

  /// Get Fibonacci sequence
  static List<int> getSequence(int n) {
    if (n <= 0) return [];
    if (n == 1) return [0];
    if (n == 2) return [0, 1];

    List<int> sequence = [0, 1];
    for (int i = 2; i < n; i++) {
      sequence.add(sequence[i - 1] + sequence[i - 2]);
    }
    return sequence;
  }

  /// Check if number is Fibonacci
  static bool isFibonacci(int number) {
    if (number < 0) return false;
    if (number <= 1) return true;

    int nSquared = number * number;
    int check1 = 5 * nSquared + 4;
    int check2 = 5 * nSquared - 4;

    return _isPerfectSquare(check1) || _isPerfectSquare(check2);
  }

  static bool _isPerfectSquare(int number) {
    int sqrtValue = sqrt(number).round();
    return sqrtValue * sqrtValue == number;
  }
}
