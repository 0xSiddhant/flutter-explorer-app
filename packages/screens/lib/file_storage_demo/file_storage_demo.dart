import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:common/common.dart';

class FileStorageDemo extends StatefulWidget {
  const FileStorageDemo({super.key});

  @override
  State<FileStorageDemo> createState() => _FileStorageDemoState();
}

class _FileStorageDemoState extends State<FileStorageDemo> {
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _fileContentController = TextEditingController();
  List<String> _files = [];
  String _currentLanguage = 'en';
  bool _isLoading = false;
  String _lastOperation = 'No operation performed';

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _fileContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.getString('file_storage_demo', _currentLanguage),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFileInputSection(),
              const SizedBox(height: 16),
              _buildFileOperationsSection(),
              const SizedBox(height: 16),
              _buildFilesListSection(),
              const SizedBox(height: 16),
              _buildOperationStatusSection(),
              const SizedBox(height: 24), // Add bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileInputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.getString('file_name', _currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fileNameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.getString(
                  'enter_file_name',
                  _currentLanguage,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.getString('file_content', _currentLanguage),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fileContentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: AppLocalizations.getString(
                  'enter_file_content',
                  _currentLanguage,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileOperationsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File Operations',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveFile,
                  child: Text(
                    AppLocalizations.getString('save_file', _currentLanguage),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _loadFile,
                  child: Text(
                    AppLocalizations.getString('load_file', _currentLanguage),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _deleteFile,
                  child: Text(
                    AppLocalizations.getString('delete_file', _currentLanguage),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _createSampleFiles,
                  child: const Text('Create Sample Files'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesListSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Files in App Documents Directory',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Fixed height for files list
              child: _files.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.getString(
                          'no_files_found',
                          _currentLanguage,
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final fileName = _files[index];
                        return ListTile(
                          leading: const Icon(Icons.insert_drive_file),
                          title: Text(fileName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () => _loadSpecificFile(fileName),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteSpecificFile(fileName),
                              ),
                            ],
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

  Widget _buildOperationStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Operation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lastOperation,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFile() async {
    if (_fileNameController.text.isEmpty ||
        _fileContentController.text.isEmpty) {
      setState(() {
        _lastOperation = 'Error: File name and content are required';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${_fileNameController.text}.txt');
      await file.writeAsString(_fileContentController.text);

      setState(() {
        _lastOperation = AppLocalizations.getString(
          'file_saved_successfully',
          _currentLanguage,
        );
        _fileNameController.clear();
        _fileContentController.clear();
      });

      await _loadFiles();
    } catch (e) {
      setState(() {
        _lastOperation =
            '${AppLocalizations.getString('error_saving_file', _currentLanguage)}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFile() async {
    if (_fileNameController.text.isEmpty) {
      setState(() {
        _lastOperation = 'Error: Please enter a file name to load';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${_fileNameController.text}.txt');

      if (await file.exists()) {
        final content = await file.readAsString();
        _fileContentController.text = content;
        setState(() {
          _lastOperation = AppLocalizations.getString(
            'file_loaded_successfully',
            _currentLanguage,
          );
        });
      } else {
        setState(() {
          _lastOperation = 'Error: File not found';
        });
      }
    } catch (e) {
      setState(() {
        _lastOperation =
            '${AppLocalizations.getString('error_loading_file', _currentLanguage)}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteFile() async {
    if (_fileNameController.text.isEmpty) {
      setState(() {
        _lastOperation = 'Error: Please enter a file name to delete';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${_fileNameController.text}.txt');

      if (await file.exists()) {
        await file.delete();
        setState(() {
          _lastOperation = AppLocalizations.getString(
            'file_deleted_successfully',
            _currentLanguage,
          );
          _fileNameController.clear();
          _fileContentController.clear();
        });
        await _loadFiles();
      } else {
        setState(() {
          _lastOperation = 'Error: File not found';
        });
      }
    } catch (e) {
      setState(() {
        _lastOperation =
            '${AppLocalizations.getString('error_deleting_file', _currentLanguage)}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSpecificFile(String fileName) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      if (await file.exists()) {
        final content = await file.readAsString();
        _fileNameController.text = fileName.replaceAll('.txt', '');
        _fileContentController.text = content;
        setState(() {
          _lastOperation = AppLocalizations.getString(
            'file_loaded_successfully',
            _currentLanguage,
          );
        });
      } else {
        setState(() {
          _lastOperation = 'Error: File not found';
        });
      }
    } catch (e) {
      setState(() {
        _lastOperation =
            '${AppLocalizations.getString('error_loading_file', _currentLanguage)}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteSpecificFile(String fileName) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      if (await file.exists()) {
        await file.delete();
        setState(() {
          _lastOperation = AppLocalizations.getString(
            'file_deleted_successfully',
            _currentLanguage,
          );
        });
        await _loadFiles();
      } else {
        setState(() {
          _lastOperation = 'Error: File not found';
        });
      }
    } catch (e) {
      setState(() {
        _lastOperation =
            '${AppLocalizations.getString('error_deleting_file', _currentLanguage)}: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createSampleFiles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final sampleFiles = [
        {
          'name': 'sample1',
          'content':
              'This is sample file 1\nCreated by Flutter Demo App\nDate: ${DateTime.now()}',
        },
        {
          'name': 'sample2',
          'content':
              'This is sample file 2\nContains some sample data\nRandom number: ${DateTime.now().millisecondsSinceEpoch % 1000}',
        },
        {
          'name': 'notes',
          'content':
              'My Notes:\n- Flutter is awesome\n- File storage works great\n- Isolates are powerful',
        },
      ];

      for (final fileData in sampleFiles) {
        final file = File('${directory.path}/${fileData['name']}.txt');
        await file.writeAsString(fileData['content']!);
      }

      setState(() {
        _lastOperation =
            'Created ${sampleFiles.length} sample files successfully';
      });

      await _loadFiles();
    } catch (e) {
      setState(() {
        _lastOperation = 'Error creating sample files: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync();
      final txtFiles = files
          .where((file) => file is File && file.path.endsWith('.txt'))
          .map((file) => file.path.split('/').last)
          .toList();

      setState(() {
        _files = txtFiles;
      });
    } catch (e) {
      setState(() {
        _lastOperation = 'Error loading files: $e';
      });
    }
  }
}
