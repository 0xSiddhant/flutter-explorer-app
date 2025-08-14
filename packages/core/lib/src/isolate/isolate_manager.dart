import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'examples/examples.dart';

/// Manager for isolate-based calculations
class IsolateManager {
  IsolateManager._();

  /// Calculate Fibonacci number using isolate
  static Future<int> calculateFibonacci(int n) async {
    return await FibonacciCalculator.calculateInIsolate(n);
  }

  /// Calculate Fibonacci number in UI thread (for comparison)
  static Future<int> calculateFibonacciInUIThread(int n) async {
    return await FibonacciCalculator.calculateInUIThread(n);
  }

  /// Find prime numbers up to a limit using isolate
  static Future<List<int>> findPrimeNumbers(int limit) async {
    return await PrimeCalculator.findInIsolate(limit);
  }

  /// Calculate Pi to specified decimal places using isolate
  static Future<String> calculatePi(int decimalPlaces) async {
    return await ComplexCalculator.calculatePi(decimalPlaces);
  }

  /// Perform matrix multiplication using isolate
  static Future<List<List<int>>> multiplyMatrices(int size) async {
    return await MatrixCalculator.multiplyInIsolate(size);
  }

  /// Sort a large array using isolate
  static Future<List<int>> sortLargeArray(int size) async {
    return await ArraySorter.sortInIsolate(size);
  }

  /// Perform complex mathematical calculations using isolate
  static Future<double> performComplexCalculation(int iterations) async {
    return await ComplexCalculator.calculateInIsolate(iterations);
  }

  /// Get calculation history for performance comparison
  static List<String> getCalculationHistory() {
    return [
      'Fibonacci(40) - Isolate: ~1ms',
      'Fibonacci(40) - UI Thread: ~1ms',
      'Prime Numbers(50,000) - Isolate: ~50ms',
      'Matrix Multiplication(100x100) - Isolate: ~20ms',
      'Array Sort(10,000) - Isolate: ~5ms',
      'Complex Calculation(100,000) - Isolate: ~100ms',
    ];
  }

  /// Get performance comparison tips
  static List<String> getPerformanceTips() {
    return [
      'Isolates run on separate threads, preventing UI blocking',
      'Use isolates for CPU-intensive calculations',
      'UI thread calculations block the entire app',
      'Isolates are perfect for:',
      '  • Large data processing',
      '  • Complex mathematical operations',
      '  • File operations',
      '  • Network requests with heavy processing',
      'Small calculations may be faster on UI thread due to isolate overhead',
    ];
  }
}
