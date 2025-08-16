import 'dart:isolate';
import 'dart:math';

/// Data analysis operations using isolate
class DataAnalyzer {
  DataAnalyzer._();

  /// Analyze large dataset using isolate
  static Future<Map<String, dynamic>> analyzeDataset(
    List<Map<String, dynamic>> data,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_analyzeDatasetIsolate, [receivePort.sendPort, data]);
    return await receivePort.first as Map<String, dynamic>;
  }

  static void _analyzeDatasetIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final data = args[1] as List<Map<String, dynamic>>;
    sendPort.send(_performAnalysis(data));
  }

  static Map<String, dynamic> _performAnalysis(
    List<Map<String, dynamic>> data,
  ) {
    if (data.isEmpty) return {};

    final values = data.map((item) => item['value'] as double).toList();

    return {
      'count': data.length,
      'sum': values.reduce((a, b) => a + b),
      'average': values.reduce((a, b) => a + b) / values.length,
      'min': values.reduce(min),
      'max': values.reduce(max),
      'median': _calculateMedian(values),
      'standardDeviation': _calculateStandardDeviation(values),
    };
  }

  static double _calculateMedian(List<double> values) {
    values.sort();
    final mid = values.length ~/ 2;
    if (values.length % 2 == 0) {
      return (values[mid - 1] + values[mid]) / 2;
    } else {
      return values[mid];
    }
  }

  static double _calculateStandardDeviation(List<double> values) {
    final mean = values.reduce((a, b) => a + b) / values.length;
    final squaredDifferences = values.map((value) => pow(value - mean, 2));
    final variance = squaredDifferences.reduce((a, b) => a + b) / values.length;
    return sqrt(variance);
  }

  /// Perform machine learning clustering using isolate
  static Future<List<List<int>>> performClustering(
    List<List<double>> points,
    int k,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_clusteringIsolate, [receivePort.sendPort, points, k]);
    return await receivePort.first as List<List<int>>;
  }

  static void _clusteringIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final points = args[1] as List<List<double>>;
    final k = args[2] as int;
    sendPort.send(_kMeansClustering(points, k));
  }

  static List<List<int>> _kMeansClustering(List<List<double>> points, int k) {
    if (points.isEmpty || k <= 0) return [];

    // Initialize centroids randomly
    final random = Random();
    final centroids = <List<double>>[];
    for (int i = 0; i < k; i++) {
      final randomPoint = points[random.nextInt(points.length)];
      centroids.add(List.from(randomPoint));
    }

    final clusters = List.generate(k, (_) => <int>[]);

    // Simple k-means iteration
    for (int iteration = 0; iteration < 10; iteration++) {
      // Clear clusters
      for (final cluster in clusters) {
        cluster.clear();
      }

      // Assign points to nearest centroid
      for (int i = 0; i < points.length; i++) {
        int nearestCentroid = 0;
        double minDistance = double.infinity;

        for (int j = 0; j < centroids.length; j++) {
          final distance = _calculateDistance(points[i], centroids[j]);
          if (distance < minDistance) {
            minDistance = distance;
            nearestCentroid = j;
          }
        }

        clusters[nearestCentroid].add(i);
      }

      // Update centroids
      for (int i = 0; i < centroids.length; i++) {
        if (clusters[i].isNotEmpty) {
          final clusterPoints = clusters[i]
              .map((index) => points[index])
              .toList();
          centroids[i] = _calculateCentroid(clusterPoints);
        }
      }
    }

    return clusters;
  }

  static double _calculateDistance(List<double> point1, List<double> point2) {
    double sum = 0;
    for (int i = 0; i < point1.length; i++) {
      sum += pow(point1[i] - point2[i], 2);
    }
    return sqrt(sum);
  }

  static List<double> _calculateCentroid(List<List<double>> points) {
    final dimensions = points[0].length;
    final centroid = List.filled(dimensions, 0.0);

    for (final point in points) {
      for (int i = 0; i < dimensions; i++) {
        centroid[i] += point[i];
      }
    }

    for (int i = 0; i < dimensions; i++) {
      centroid[i] /= points.length;
    }

    return centroid;
  }

  /// Perform time series analysis using isolate
  static Future<Map<String, dynamic>> analyzeTimeSeries(
    List<double> values,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_timeSeriesIsolate, [receivePort.sendPort, values]);
    return await receivePort.first as Map<String, dynamic>;
  }

  static void _timeSeriesIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final values = args[1] as List<double>;
    sendPort.send(_performTimeSeriesAnalysis(values));
  }

  static Map<String, dynamic> _performTimeSeriesAnalysis(List<double> values) {
    if (values.length < 2) return {};

    final trends = <double>[];
    final seasonality = <double>[];

    // Calculate trends (simple moving average)
    for (int i = 1; i < values.length; i++) {
      trends.add(values[i] - values[i - 1]);
    }

    // Calculate seasonality (assuming 7-day pattern)
    final seasonLength = 7;
    if (values.length >= seasonLength) {
      for (int i = seasonLength; i < values.length; i++) {
        seasonality.add(values[i] - values[i - seasonLength]);
      }
    }

    return {
      'trends': trends,
      'seasonality': seasonality,
      'volatility': _calculateVolatility(values),
      'autocorrelation': _calculateAutocorrelation(values),
    };
  }

  static double _calculateVolatility(List<double> values) {
    final returns = <double>[];
    for (int i = 1; i < values.length; i++) {
      returns.add((values[i] - values[i - 1]) / values[i - 1]);
    }

    final mean = returns.reduce((a, b) => a + b) / returns.length;
    final variance =
        returns.map((r) => pow(r - mean, 2)).reduce((a, b) => a + b) /
        returns.length;
    return sqrt(variance);
  }

  static double _calculateAutocorrelation(List<double> values) {
    if (values.length < 2) return 0;

    final mean = values.reduce((a, b) => a + b) / values.length;
    final variance =
        values.map((v) => pow(v - mean, 2)).reduce((a, b) => a + b) /
        values.length;

    double autocorr = 0;
    for (int i = 1; i < values.length; i++) {
      autocorr += (values[i] - mean) * (values[i - 1] - mean);
    }

    return autocorr / (variance * (values.length - 1));
  }
}
