import 'dart:isolate';
import 'dart:math';

/// Array sorting operations using isolate
class ArraySorter {
  ArraySorter._();

  /// Sort a large array using isolate
  static Future<List<int>> sortInIsolate(int size) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_sortArrayIsolate, [receivePort.sendPort, size]);
    return await receivePort.first as List<int>;
  }

  static void _sortArrayIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final size = args[1] as int;
    sendPort.send(_sortArray(size));
  }

  static List<int> _sortArray(int size) {
    List<int> array = _generateRandomArray(size);
    array.sort();
    return array;
  }

  static List<int> _generateRandomArray(int size) {
    Random random = Random();
    return List.generate(size, (index) => random.nextInt(10000));
  }

  /// Quick sort implementation
  static List<int> quickSort(List<int> array) {
    if (array.length <= 1) return array;

    int pivot = array[array.length ~/ 2];
    List<int> less = [];
    List<int> equal = [];
    List<int> greater = [];

    for (int element in array) {
      if (element < pivot) {
        less.add(element);
      } else if (element == pivot) {
        equal.add(element);
      } else {
        greater.add(element);
      }
    }

    return [...quickSort(less), ...equal, ...quickSort(greater)];
  }

  /// Merge sort implementation
  static List<int> mergeSort(List<int> array) {
    if (array.length <= 1) return array;

    int mid = array.length ~/ 2;
    List<int> left = mergeSort(array.sublist(0, mid));
    List<int> right = mergeSort(array.sublist(mid));

    return _merge(left, right);
  }

  static List<int> _merge(List<int> left, List<int> right) {
    List<int> result = [];
    int i = 0, j = 0;

    while (i < left.length && j < right.length) {
      if (left[i] <= right[j]) {
        result.add(left[i]);
        i++;
      } else {
        result.add(right[j]);
        j++;
      }
    }

    result.addAll(left.sublist(i));
    result.addAll(right.sublist(j));

    return result;
  }

  /// Bubble sort implementation
  static List<int> bubbleSort(List<int> array) {
    List<int> result = List.from(array);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (result[j] > result[j + 1]) {
          int temp = result[j];
          result[j] = result[j + 1];
          result[j + 1] = temp;
        }
      }
    }

    return result;
  }

  /// Find the kth largest element
  static int findKthLargest(List<int> array, int k) {
    List<int> sorted = List.from(array)..sort();
    return sorted[sorted.length - k];
  }

  /// Find the kth smallest element
  static int findKthSmallest(List<int> array, int k) {
    List<int> sorted = List.from(array)..sort();
    return sorted[k - 1];
  }

  /// Check if array is sorted
  static bool isSorted(List<int> array) {
    for (int i = 1; i < array.length; i++) {
      if (array[i] < array[i - 1]) return false;
    }
    return true;
  }

  /// Remove duplicates from sorted array
  static List<int> removeDuplicates(List<int> array) {
    if (array.isEmpty) return [];

    List<int> result = [array[0]];
    for (int i = 1; i < array.length; i++) {
      if (array[i] != array[i - 1]) {
        result.add(array[i]);
      }
    }
    return result;
  }
}
