import 'dart:async';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';

/// Demo screen for isolate operations
class BackgroundTasksScreen extends StatefulWidget {
  const BackgroundTasksScreen({super.key});

  @override
  State<BackgroundTasksScreen> createState() => _BackgroundTasksScreenState();
}

class _BackgroundTasksScreenState extends State<BackgroundTasksScreen> {
  String _result = 'No calculation performed yet';
  List<int> _primeNumbers = [];
  bool _isCalculating = false;
  double _progress = 0.0;
  int _calculationTime = 0;
  final List<String> _calculationHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('background_tasks')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoSection(),
              const SizedBox(height: 20),
              _buildControlsSection(),
              const SizedBox(height: 20),
              _buildResultsSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Isolate Operations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Isolates allow you to run CPU-intensive operations on separate threads without blocking the UI.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Try the calculations below to see the difference between UI thread and isolate performance.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculations',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isCalculating ? null : _calculateFibonacci,
                  child: Text(
                    AppLocalizations.getString('fibonacci_ui_thread'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isCalculating
                      ? null
                      : _calculateFibonacciInIsolate,
                  child: Text(
                    AppLocalizations.getString('fibonacci_isolate'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isCalculating ? null : _findPrimeNumbers,
                  child: Text(
                    AppLocalizations.getString('find_prime_numbers'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isCalculating ? null : _multiplyMatrices,
                  child: Text(
                    AppLocalizations.getString('matrix_multiplication'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isCalculating ? null : _sortLargeArray,
                  child: Text(
                    AppLocalizations.getString('sort_large_array'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isCalculating ? null : _complexCalculation,
                  child: Text(
                    AppLocalizations.getString('complex_calculation'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('results'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (_isCalculating) ...[
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('calculating')} ${(_progress * 100).toInt()}%',
              ),
            ],
            const SizedBox(height: 12),
            Text('${AppLocalizations.getString('result')}: $_result'),
            if (_calculationTime > 0) ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('time')}: ${_calculationTime}ms',
              ),
            ],
            if (_primeNumbers.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('prime_numbers_found')} ${_primeNumbers.length}',
              ),
              const SizedBox(height: 4),
              Text(
                '${AppLocalizations.getString('first_10')}: ${_primeNumbers.take(10).join(', ')}',
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Calculation History',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _calculationHistory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      _calculationHistory[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // UI Thread calculation (will block the UI)
  Future<void> _calculateFibonacci() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Calculating...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final result = await IsolateManager.calculateFibonacciInUIThread(40);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Fibonacci(40) = $result';
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Fibonacci(40) = $result (${stopwatch.elapsedMilliseconds}ms) - UI Thread',
      );
    });
  }

  // Isolate calculation (won't block the UI)
  Future<void> _calculateFibonacciInIsolate() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Calculating in isolate...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final result = await IsolateManager.calculateFibonacci(40);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Fibonacci(40) = $result';
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Fibonacci(40) = $result (${stopwatch.elapsedMilliseconds}ms) - Isolate',
      );
    });
  }

  Future<void> _findPrimeNumbers() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Finding prime numbers...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final primes = await IsolateManager.findPrimeNumbers(50000);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Found ${primes.length} prime numbers up to 50,000';
      _primeNumbers = primes;
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Prime numbers (${stopwatch.elapsedMilliseconds}ms) - Isolate',
      );
    });
  }

  Future<void> _multiplyMatrices() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Multiplying matrices...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final _ = await IsolateManager.multiplyMatrices(100);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Matrix multiplication (100x100) completed';
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Matrix multiplication (${stopwatch.elapsedMilliseconds}ms) - Isolate',
      );
    });
  }

  Future<void> _sortLargeArray() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Sorting large array...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final _ = await IsolateManager.sortLargeArray(10000);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Array sorting (10,000 elements) completed';
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Array sorting (${stopwatch.elapsedMilliseconds}ms) - Isolate',
      );
    });
  }

  Future<void> _complexCalculation() async {
    setState(() {
      _isCalculating = true;
      _progress = 0.0;
      _result = 'Performing complex calculation...';
      _primeNumbers.clear();
      _calculationTime = 0;
    });

    final stopwatch = Stopwatch()..start();

    Timer? progressTimer;
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
      }
    });

    final result = await IsolateManager.performComplexCalculation(100000);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result =
          'Complex calculation (100,000 iterations) completed. Result: $result';
      _calculationTime = stopwatch.elapsedMilliseconds;
      _isCalculating = false;
      _progress = 1.0;
      _calculationHistory.insert(
        0,
        'Complex calculation (${stopwatch.elapsedMilliseconds}ms) - Isolate',
      );
    });
  }
}
