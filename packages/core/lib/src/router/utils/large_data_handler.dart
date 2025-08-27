import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Utility class for handling large data in deep link parameters
/// Supports compression, encoding, and validation for complex data structures
class LargeDataHandler {
  /// Maximum allowed size for a single parameter (in characters)
  static const int maxParameterSize = 2000;

  /// Maximum allowed size for compressed data (in characters)
  static const int maxCompressedSize = 4000;

  /// Encode complex data structure to a deep link parameter
  ///
  /// [data] - The data to encode (Map, List, or any serializable object)
  /// [compress] - Whether to compress the data (default: true)
  ///
  /// Returns encoded string suitable for URL parameters
  static String encodeData(dynamic data, {bool compress = true}) {
    try {
      // Convert to JSON string
      final jsonString = jsonEncode(data);

      // Compress if requested and data is large enough
      if (compress && jsonString.length > 100) {
        return _compressAndEncode(jsonString);
      } else {
        // Simple base64 encoding for smaller data
        return base64Encode(utf8.encode(jsonString));
      }
    } catch (e) {
      debugPrint('LargeDataHandler: Error encoding data: $e');
      throw ArgumentError('Failed to encode data: $e');
    }
  }

  /// Decode deep link parameter back to original data structure
  ///
  /// [encodedData] - The encoded parameter string
  ///
  /// Returns the original data structure
  static dynamic decodeData(String encodedData) {
    try {
      // Validate input
      if (encodedData.isEmpty) {
        throw ArgumentError('Encoded data cannot be empty');
      }

      if (encodedData.length > maxCompressedSize) {
        throw ArgumentError('Encoded data exceeds maximum size limit');
      }

      String jsonString;

      // Try to detect if data is compressed
      if (_isCompressed(encodedData)) {
        jsonString = _decompressAndDecode(encodedData);
      } else {
        // Simple base64 decoding
        jsonString = utf8.decode(base64Decode(encodedData));
      }

      // Parse JSON back to original structure
      return jsonDecode(jsonString);
    } catch (e) {
      debugPrint('LargeDataHandler: Error decoding data: $e');
      throw ArgumentError('Failed to decode data: $e');
    }
  }

  /// Encode a list of items as a deep link parameter
  ///
  /// [items] - List of items to encode
  /// [itemEncoder] - Function to encode each item to string
  ///
  /// Returns encoded string
  static String encodeList<T>(List<T> items, String Function(T) itemEncoder) {
    if (items.isEmpty) return '';

    final encodedItems = items.map(itemEncoder).toList();
    return encodeData(encodedItems);
  }

  /// Decode a list from deep link parameter
  ///
  /// [encodedData] - The encoded parameter string
  /// [itemDecoder] - Function to decode each item from string
  ///
  /// Returns list of decoded items
  static List<T> decodeList<T>(
    String encodedData,
    T Function(String) itemDecoder,
  ) {
    if (encodedData.isEmpty) return [];

    final decodedData = decodeData(encodedData);
    if (decodedData is! List) {
      throw ArgumentError('Decoded data is not a list');
    }

    return decodedData.cast<String>().map(itemDecoder).toList();
  }

  /// Create a deep link URL with large data parameters
  ///
  /// [baseUrl] - Base deep link URL (e.g., 'frouter://feature')
  /// [dataParams] - Map of parameter names to data objects
  ///
  /// Returns complete deep link URL
  static String createDeepLinkWithData(
    String baseUrl,
    Map<String, dynamic> dataParams,
  ) {
    final uri = Uri.parse(baseUrl);
    final queryParams = <String, String>{};

    // Add existing query parameters
    queryParams.addAll(uri.queryParameters);

    // Encode and add data parameters
    for (final entry in dataParams.entries) {
      final encodedData = encodeData(entry.value);
      queryParams[entry.key] = encodedData;
    }

    // Build final URL
    final finalUri = uri.replace(queryParameters: queryParams);
    return finalUri.toString();
  }

  /// Extract and decode large data parameters from a deep link URL
  ///
  /// [url] - The deep link URL
  /// [dataParamNames] - Names of parameters that contain large data
  ///
  /// Returns map of parameter names to decoded data
  static Map<String, dynamic> extractDataFromDeepLink(
    String url,
    List<String> dataParamNames,
  ) {
    final uri = Uri.parse(url);
    final result = <String, dynamic>{};

    for (final paramName in dataParamNames) {
      final encodedValue = uri.queryParameters[paramName];
      if (encodedValue != null && encodedValue.isNotEmpty) {
        try {
          result[paramName] = decodeData(encodedValue);
        } catch (e) {
          debugPrint('LargeDataHandler: Failed to decode $paramName: $e');
          // Continue with other parameters
        }
      }
    }

    return result;
  }

  /// Validate if data can be safely encoded for deep links
  ///
  /// [data] - The data to validate
  ///
  /// Returns true if data can be encoded, false otherwise
  static bool canEncodeData(dynamic data) {
    try {
      final jsonString = jsonEncode(data);
      return jsonString.length <= maxParameterSize;
    } catch (e) {
      return false;
    }
  }

  /// Get estimated encoded size for data
  ///
  /// [data] - The data to estimate
  ///
  /// Returns estimated size in characters
  static int getEstimatedEncodedSize(dynamic data) {
    try {
      final jsonString = jsonEncode(data);
      // Base64 encoding increases size by ~33%
      return (jsonString.length * 1.33).round();
    } catch (e) {
      return -1;
    }
  }

  // Private helper methods

  /// Simple compression using gzip (if available) or custom compression
  static String _compressAndEncode(String data) {
    try {
      // For now, use base64 encoding with a compression marker
      // In a real implementation, you might use gzip compression
      final compressed = base64Encode(utf8.encode(data));
      return 'compressed:$compressed';
    } catch (e) {
      // Fallback to simple base64
      return base64Encode(utf8.encode(data));
    }
  }

  /// Decompress and decode data
  static String _decompressAndDecode(String encodedData) {
    if (encodedData.startsWith('compressed:')) {
      final compressed = encodedData.substring(11);
      return utf8.decode(base64Decode(compressed));
    } else {
      return utf8.decode(base64Decode(encodedData));
    }
  }

  /// Check if data appears to be compressed
  static bool _isCompressed(String data) {
    return data.startsWith('compressed:');
  }
}

/// Extension methods for easier data handling
extension LargeDataHandlerExtensions on Map<String, dynamic> {
  /// Encode this map as a deep link parameter
  String encodeAsDeepLinkParam({bool compress = true}) {
    return LargeDataHandler.encodeData(this, compress: compress);
  }
}

extension LargeDataHandlerListExtensions<T> on List<T> {
  /// Encode this list as a deep link parameter
  String encodeAsDeepLinkParam(String Function(T) itemEncoder) {
    return LargeDataHandler.encodeList(this, itemEncoder);
  }
}
