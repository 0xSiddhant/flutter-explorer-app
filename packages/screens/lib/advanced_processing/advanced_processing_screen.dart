import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';

/// Advanced isolate examples demo screen
class AdvancedProcessingScreen extends StatefulWidget {
  const AdvancedProcessingScreen({super.key});

  @override
  State<AdvancedProcessingScreen> createState() =>
      _AdvancedProcessingScreenState();
}

class _AdvancedProcessingScreenState extends State<AdvancedProcessingScreen> {
  String _result = 'No operation performed yet';
  bool _isProcessing = false;
  double _progress = 0.0;
  int _processingTime = 0;
  final List<String> _operationHistory = [];
  Uint8List? _downloadedImage;
  Map<String, dynamic>? _analysisResult;
  List<Map<String, dynamic>>? _generatedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.getString('advanced_processing')),
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
              _buildImageSection(),
              const SizedBox(height: 20),
              _buildDataProcessingSection(),
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
              'Advanced Isolate Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Real-world scenarios where isolates are essential for maintaining UI responsiveness.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Examples include image downloading, file processing, data analysis, and machine learning algorithms.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Image Operations',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isProcessing ? null : _downloadImage,
                  child: Text(
                    AppLocalizations.getString('download_image'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _processImage,
                  child: Text(
                    AppLocalizations.getString('process_image'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _generateThumbnail,
                  child: Text(
                    AppLocalizations.getString('generate_thumbnail'),
                  ),
                ),
              ],
            ),
            if (_downloadedImage != null) ...[
              const SizedBox(height: 12),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataProcessingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Processing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isProcessing ? null : _processTextFile,
                  child: Text(
                    AppLocalizations.getString('process_text_file'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _generateDataset,
                  child: Text(
                    AppLocalizations.getString('generate_dataset'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _analyzeData,
                  child: Text(AppLocalizations.getString('analyze_data')),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _performClustering,
                  child: Text(
                    AppLocalizations.getString('perform_clustering'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _compressData,
                  child: Text(
                    AppLocalizations.getString('compress_data'),
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
            if (_isProcessing) ...[
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('processing')} ${(_progress * 100).toInt()}%',
              ),
            ],
            const SizedBox(height: 12),
            Text('${AppLocalizations.getString('result')}: $_result'),
            if (_processingTime > 0) ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('time')}: ${_processingTime}ms',
              ),
            ],
            if (_analysisResult != null) ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('analysis')}: ${_analysisResult.toString()}',
              ),
            ],
            if (_generatedData != null) ...[
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.getString('generated_records')} ${_generatedData!.length}',
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Operation History',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: _operationHistory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      _operationHistory[index],
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

  Future<void> _downloadImage() async {
    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Downloading image...';
      _processingTime = 0;
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

    try {
      final imageData = await IsolateManager.downloadImage(
        'https://example.com/image.jpg',
      );

      stopwatch.stop();
      progressTimer.cancel();

      setState(() {
        _downloadedImage = imageData;
        _result = 'Image downloaded successfully (${imageData.length} bytes)';
        _processingTime = stopwatch.elapsedMilliseconds;
        _isProcessing = false;
        _progress = 1.0;
        _operationHistory.insert(
          0,
          'Image download (${stopwatch.elapsedMilliseconds}ms)',
        );
      });
    } catch (e) {
      stopwatch.stop();
      progressTimer.cancel();

      setState(() {
        _result = 'Failed to download image: $e';
        _processingTime = stopwatch.elapsedMilliseconds;
        _isProcessing = false;
        _progress = 1.0;
        _operationHistory.insert(
          0,
          'Image download failed (${stopwatch.elapsedMilliseconds}ms)',
        );
      });
    }
  }

  Future<void> _processImage() async {
    if (_downloadedImage == null) {
      setState(() {
        _result = 'Please download an image first';
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Processing image...';
      _processingTime = 0;
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

    final processedImage = await IsolateManager.processImage(
      _downloadedImage!,
      maxWidth: 800,
      maxHeight: 600,
    );

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Image processed successfully (${processedImage.length} bytes)';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Image processing (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _generateThumbnail() async {
    if (_downloadedImage == null) {
      setState(() {
        _result = 'Please download an image first';
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Generating thumbnail...';
      _processingTime = 0;
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

    final thumbnail = await ImageDownloader.generateThumbnail(
      _downloadedImage!,
    );

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Thumbnail generated (${thumbnail.length} bytes)';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Thumbnail generation (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _processTextFile() async {
    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Processing text file...';
      _processingTime = 0;
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

    // Generate sample text content
    final sampleText = List.generate(1000, (i) => 'word${i % 100}').join(' ');
    final wordCount = await IsolateManager.processTextFile(sampleText);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Text processed: ${wordCount.length} unique words found';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Text processing (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _generateDataset() async {
    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Generating dataset...';
      _processingTime = 0;
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

    final data = await IsolateManager.generateDataset(1000);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _generatedData = data;
      _result = 'Dataset generated: ${data.length} records';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Dataset generation (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _analyzeData() async {
    if (_generatedData == null) {
      setState(() {
        _result = 'Please generate a dataset first';
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Analyzing data...';
      _processingTime = 0;
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

    final analysis = await IsolateManager.analyzeDataset(_generatedData!);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _analysisResult = analysis;
      _result = 'Data analysis completed';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Data analysis (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _performClustering() async {
    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Performing clustering...';
      _processingTime = 0;
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

    // Generate sample 2D points
    final points = List.generate(500, (i) => [i * 0.1, sin(i * 0.1)]);
    final clusters = await IsolateManager.performClustering(points, 5);

    stopwatch.stop();
    progressTimer.cancel();

    setState(() {
      _result = 'Clustering completed: ${clusters.length} clusters found';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Clustering (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }

  Future<void> _compressData() async {
    setState(() {
      _isProcessing = true;
      _progress = 0.0;
      _result = 'Compressing data...';
      _processingTime = 0;
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

    // Generate sample data
    final sampleData = Uint8List.fromList(
      List.generate(100000, (i) => i % 256),
    );
    final compressedData = await IsolateManager.compressData(sampleData);

    stopwatch.stop();
    progressTimer.cancel();

    final compressionRatio = (sampleData.length / compressedData.length)
        .toStringAsFixed(2);

    setState(() {
      _result =
          'Data compressed: ${sampleData.length} → ${compressedData.length} bytes (${compressionRatio}x)';
      _processingTime = stopwatch.elapsedMilliseconds;
      _isProcessing = false;
      _progress = 1.0;
      _operationHistory.insert(
        0,
        'Data compression (${stopwatch.elapsedMilliseconds}ms)',
      );
    });
  }
}
