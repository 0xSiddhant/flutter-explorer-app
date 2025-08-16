import 'dart:isolate';

/// Prime number calculations using isolate
class PrimeCalculator {
  PrimeCalculator._();

  /// Find prime numbers using isolate
  static Future<List<int>> findInIsolate(int limit) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_primeIsolate, [receivePort.sendPort, limit]);
    return await receivePort.first as List<int>;
  }

  static void _primeIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final limit = args[1] as int;
    sendPort.send(_findPrimes(limit));
  }

  /// Sieve of Eratosthenes implementation
  static List<int> _findPrimes(int limit) {
    if (limit < 2) return [];

    List<bool> isPrime = List.filled(limit + 1, true);
    isPrime[0] = isPrime[1] = false;

    for (int i = 2; i * i <= limit; i++) {
      if (isPrime[i]) {
        for (int j = i * i; j <= limit; j += i) {
          isPrime[j] = false;
        }
      }
    }

    List<int> primes = [];
    for (int i = 2; i <= limit; i++) {
      if (isPrime[i]) {
        primes.add(i);
      }
    }

    return primes;
  }

  /// Check if number is prime
  static bool isPrime(int number) {
    if (number < 2) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;

    for (int i = 3; i * i <= number; i += 2) {
      if (number % i == 0) return false;
    }
    return true;
  }

  /// Get nth prime number
  static int getNthPrime(int n) {
    if (n <= 0) return -1;
    if (n == 1) return 2;

    int count = 1;
    int candidate = 3;

    while (count < n) {
      if (isPrime(candidate)) {
        count++;
      }
      candidate += 2;
    }

    return candidate - 2;
  }

  /// Get prime factorization
  static Map<int, int> getPrimeFactors(int number) {
    Map<int, int> factors = {};

    while (number % 2 == 0) {
      factors[2] = (factors[2] ?? 0) + 1;
      number ~/= 2;
    }

    for (int i = 3; i * i <= number; i += 2) {
      while (number % i == 0) {
        factors[i] = (factors[i] ?? 0) + 1;
        number ~/= i;
      }
    }

    if (number > 1) {
      factors[number] = (factors[number] ?? 0) + 1;
    }

    return factors;
  }

  /// Get twin primes
  static List<List<int>> getTwinPrimes(int limit) {
    List<int> primes = _findPrimes(limit);
    List<List<int>> twinPrimes = [];

    for (int i = 0; i < primes.length - 1; i++) {
      if (primes[i + 1] - primes[i] == 2) {
        twinPrimes.add([primes[i], primes[i + 1]]);
      }
    }

    return twinPrimes;
  }
}
