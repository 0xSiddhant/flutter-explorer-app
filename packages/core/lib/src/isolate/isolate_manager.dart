import 'dart:async';
import 'dart:typed_data';

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

  /// Download image using isolate
  static Future<Uint8List> downloadImage(String url) async {
    return await ImageDownloader.downloadImage(url);
  }

  /// Process image using isolate
  static Future<Uint8List> processImage(
    Uint8List imageData, {
    int? maxWidth,
    int? maxHeight,
    int quality = 80,
  }) async {
    return await ImageDownloader.processImage(
      imageData,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      quality: quality,
    );
  }

  /// Process text file using isolate
  static Future<Map<String, int>> processTextFile(String content) async {
    return await FileProcessor.processTextFile(content);
  }

  /// Compress data using isolate
  static Future<Uint8List> compressData(Uint8List data) async {
    return await FileProcessor.compressData(data);
  }

  /// Parse CSV data using isolate
  static Future<List<Map<String, String>>> parseCSV(String csvData) async {
    return await FileProcessor.parseCSV(csvData);
  }

  /// Generate dataset using isolate
  static Future<List<Map<String, dynamic>>> generateDataset(int size) async {
    return await FileProcessor.generateDataset(size);
  }

  /// Analyze dataset using isolate
  static Future<Map<String, dynamic>> analyzeDataset(
    List<Map<String, dynamic>> data,
  ) async {
    return await DataAnalyzer.analyzeDataset(data);
  }

  /// Perform clustering using isolate
  static Future<List<List<int>>> performClustering(
    List<List<double>> points,
    int k,
  ) async {
    return await DataAnalyzer.performClustering(points, k);
  }

  /// Analyze time series using isolate
  static Future<Map<String, dynamic>> analyzeTimeSeries(
    List<double> values,
  ) async {
    return await DataAnalyzer.analyzeTimeSeries(values);
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
      'Image Download - Isolate: ~200ms',
      'Text Processing(10,000 words) - Isolate: ~30ms',
      'Data Analysis(1,000 records) - Isolate: ~80ms',
      'Clustering(500 points) - Isolate: ~150ms',
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
      '  • Image processing and downloads',
      '  • Machine learning algorithms',
      '  • Data analysis and clustering',
      'Small calculations may be faster on UI thread due to isolate overhead',
    ];
  }
}
