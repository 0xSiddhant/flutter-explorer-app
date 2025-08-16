import 'dart:isolate';
import 'dart:math';

/// Matrix operations using isolate for non-blocking computations
class MatrixCalculator {
  MatrixCalculator._();

  /// Multiply two square matrices using isolate
  static Future<List<List<int>>> multiplyInIsolate(int size) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_matrixMultiplicationIsolate, [
      receivePort.sendPort,
      size,
    ]);
    return await receivePort.first as List<List<int>>;
  }

  static void _matrixMultiplicationIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final size = args[1] as int;
    sendPort.send(_multiplyMatrices(size));
  }

  static List<List<int>> _multiplyMatrices(int size) {
    List<List<int>> matrixA = _generateRandomMatrix(size);
    List<List<int>> matrixB = _generateRandomMatrix(size);
    return _multiply(matrixA, matrixB);
  }

  static List<List<int>> _generateRandomMatrix(int size) {
    Random random = Random();
    List<List<int>> matrix = [];

    for (int i = 0; i < size; i++) {
      List<int> row = [];
      for (int j = 0; j < size; j++) {
        row.add(random.nextInt(10));
      }
      matrix.add(row);
    }

    return matrix;
  }

  static List<List<int>> _multiply(
    List<List<int>> matrixA,
    List<List<int>> matrixB,
  ) {
    int rowsA = matrixA.length;
    int colsA = matrixA[0].length;
    int colsB = matrixB[0].length;

    List<List<int>> result = List.generate(rowsA, (i) => List.filled(colsB, 0));

    for (int i = 0; i < rowsA; i++) {
      for (int j = 0; j < colsB; j++) {
        for (int k = 0; k < colsA; k++) {
          result[i][j] += matrixA[i][k] * matrixB[k][j];
        }
      }
    }

    return result;
  }

  /// Add two matrices
  static List<List<int>> add(List<List<int>> matrixA, List<List<int>> matrixB) {
    int rows = matrixA.length;
    int cols = matrixA[0].length;

    List<List<int>> result = List.generate(rows, (i) => List.filled(cols, 0));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result[i][j] = matrixA[i][j] + matrixB[i][j];
      }
    }

    return result;
  }

  /// Transpose a matrix
  static List<List<int>> transpose(List<List<int>> matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;

    List<List<int>> result = List.generate(cols, (i) => List.filled(rows, 0));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result[j][i] = matrix[i][j];
      }
    }

    return result;
  }

  /// Calculate determinant of a 2x2 matrix
  static int determinant2x2(List<List<int>> matrix) {
    if (matrix.length != 2 || matrix[0].length != 2) {
      throw ArgumentError('Matrix must be 2x2');
    }

    return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
  }

  /// Check if a matrix is symmetric
  static bool isSymmetric(List<List<int>> matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;

    if (rows != cols) return false;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (matrix[i][j] != matrix[j][i]) return false;
      }
    }

    return true;
  }

  /// Format matrix for display
  static String formatMatrix(List<List<int>> matrix) {
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < matrix.length; i++) {
      buffer.write('[');
      for (int j = 0; j < matrix[i].length; j++) {
        buffer.write('${matrix[i][j]}');
        if (j < matrix[i].length - 1) buffer.write(', ');
      }
      buffer.write(']');
      if (i < matrix.length - 1) buffer.write('\n');
    }

    return buffer.toString();
  }
}
