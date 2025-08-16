import 'dart:isolate';
import 'dart:typed_data';

/// File processing operations using isolate
class FileProcessor {
  FileProcessor._();

  /// Process large text file using isolate
  static Future<Map<String, int>> processTextFile(String content) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_processTextFileIsolate, [
      receivePort.sendPort,
      content,
    ]);
    return await receivePort.first as Map<String, int>;
  }

  static void _processTextFileIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final content = args[1] as String;
    sendPort.send(_analyzeText(content));
  }

  static Map<String, int> _analyzeText(String content) {
    final words = content.toLowerCase().split(RegExp(r'\s+'));
    final wordCount = <String, int>{};

    for (final word in words) {
      if (word.isNotEmpty) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
      }
    }

    return wordCount;
  }

  /// Compress data using isolate
  static Future<Uint8List> compressData(Uint8List data) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_compressDataIsolate, [receivePort.sendPort, data]);
    return await receivePort.first as Uint8List;
  }

  static void _compressDataIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final data = args[1] as Uint8List;
    sendPort.send(_simulateCompression(data));
  }

  static Uint8List _simulateCompression(Uint8List data) {
    // Simulate compression algorithm
    final compressed = <int>[];
    int count = 1;

    for (int i = 1; i < data.length; i++) {
      if (data[i] == data[i - 1] && count < 255) {
        count++;
      } else {
        compressed.add(count);
        compressed.add(data[i - 1]);
        count = 1;
      }
    }

    // Add last group
    compressed.add(count);
    compressed.add(data.last);

    return Uint8List.fromList(compressed);
  }

  /// Parse CSV data using isolate
  static Future<List<Map<String, String>>> parseCSV(String csvData) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_parseCSVIsolate, [receivePort.sendPort, csvData]);
    return await receivePort.first as List<Map<String, String>>;
  }

  static void _parseCSVIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final csvData = args[1] as String;
    sendPort.send(_parseCSVData(csvData));
  }

  static List<Map<String, String>> _parseCSVData(String csvData) {
    final lines = csvData.split('\n');
    if (lines.isEmpty) return [];

    final headers = lines[0].split(',');
    final result = <Map<String, String>>[];

    for (int i = 1; i < lines.length; i++) {
      if (lines[i].trim().isEmpty) continue;

      final values = lines[i].split(',');
      final row = <String, String>{};

      for (int j = 0; j < headers.length && j < values.length; j++) {
        row[headers[j].trim()] = values[j].trim();
      }

      result.add(row);
    }

    return result;
  }

  /// Generate large dataset using isolate
  static Future<List<Map<String, dynamic>>> generateDataset(int size) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_generateDatasetIsolate, [receivePort.sendPort, size]);
    return await receivePort.first as List<Map<String, dynamic>>;
  }

  static void _generateDatasetIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final size = args[1] as int;
    sendPort.send(_generateData(size));
  }

  static List<Map<String, dynamic>> _generateData(int size) {
    final data = <Map<String, dynamic>>[];

    for (int i = 0; i < size; i++) {
      data.add({
        'id': i,
        'name': 'Item $i',
        'value': i * 1.5,
        'category': 'Category ${i % 5}',
        'timestamp': DateTime.now().millisecondsSinceEpoch + i,
      });
    }

    return data;
  }

  /// Encrypt data using isolate
  static Future<Uint8List> encryptData(Uint8List data, String key) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_encryptDataIsolate, [receivePort.sendPort, data, key]);
    return await receivePort.first as Uint8List;
  }

  static void _encryptDataIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final data = args[1] as Uint8List;
    final key = args[2] as String;
    sendPort.send(_simulateEncryption(data, key));
  }

  static Uint8List _simulateEncryption(Uint8List data, String key) {
    final keyBytes = key.codeUnits;
    final encrypted = <int>[];

    for (int i = 0; i < data.length; i++) {
      final keyByte = keyBytes[i % keyBytes.length];
      encrypted.add(data[i] ^ keyByte);
    }

    return Uint8List.fromList(encrypted);
  }
}
