import 'dart:isolate';
import 'dart:math';

/// Complex mathematical calculations using isolate
class ComplexCalculator {
  ComplexCalculator._();

  /// Perform complex mathematical calculations using isolate
  static Future<double> calculateInIsolate(int iterations) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_complexCalculationIsolate, [
      receivePort.sendPort,
      iterations,
    ]);
    return await receivePort.first as double;
  }

  static void _complexCalculationIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final iterations = args[1] as int;
    sendPort.send(_computeComplexCalculation(iterations));
  }

  static double _computeComplexCalculation(int iterations) {
    double sum = 0.0;
    for (int i = 0; i < iterations; i++) {
      sum += sqrt(i.toDouble()) * sin(i * 0.1);
    }
    return sum;
  }

  /// Calculate Pi to specified decimal places
  static Future<String> calculatePi(int decimalPlaces) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_piCalculationIsolate, [
      receivePort.sendPort,
      decimalPlaces,
    ]);
    return await receivePort.first as String;
  }

  static void _piCalculationIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final decimalPlaces = args[1] as int;
    sendPort.send(_computePi(decimalPlaces));
  }

  static String _computePi(int decimalPlaces) {
    // Leibniz formula for Pi: π/4 = 1 - 1/3 + 1/5 - 1/7 + ...
    double pi = 0.0;
    int sign = 1;

    for (int i = 0; i < decimalPlaces * 1000; i++) {
      pi += sign / (2 * i + 1);
      sign = -sign;
    }

    pi *= 4;
    return pi.toStringAsFixed(decimalPlaces);
  }

  /// Calculate factorial
  static int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }

  /// Calculate power using fast exponentiation
  static int power(int base, int exponent) {
    if (exponent == 0) return 1;
    if (exponent == 1) return base;

    int half = power(base, exponent ~/ 2);
    if (exponent % 2 == 0) {
      return half * half;
    } else {
      return half * half * base;
    }
  }

  /// Calculate greatest common divisor
  static int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Calculate least common multiple
  static int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b);
  }

  /// Check if number is perfect square
  static bool isPerfectSquare(int number) {
    int sqrtValue = sqrt(number).round();
    return sqrtValue * sqrtValue == number;
  }

  /// Generate random number in range
  static int randomInRange(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  /// Calculate sum of digits
  static int sumOfDigits(int number) {
    int sum = 0;
    while (number > 0) {
      sum += number % 10;
      number ~/= 10;
    }
    return sum;
  }

  /// Check if number is palindrome
  static bool isPalindrome(int number) {
    String numStr = number.toString();
    return numStr == numStr.split('').reversed.join();
  }

  /// Calculate Fibonacci number (iterative)
  static int fibonacci(int n) {
    if (n <= 1) return n;

    int a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
      int temp = a + b;
      a = b;
      b = temp;
    }
    return b;
  }

  /// Calculate sum of series: 1 + 2 + 3 + ... + n
  static int sumOfSeries(int n) {
    return (n * (n + 1)) ~/ 2;
  }

  /// Calculate sum of squares: 1² + 2² + 3² + ... + n²
  static int sumOfSquares(int n) {
    return (n * (n + 1) * (2 * n + 1)) ~/ 6;
  }
}
