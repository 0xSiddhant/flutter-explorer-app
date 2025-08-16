class ThemeControlModel {
  final bool isDarkMode;
  final bool isHighContrast;
  final double textScaleFactor;

  const ThemeControlModel({
    required this.isDarkMode,
    required this.isHighContrast,
    required this.textScaleFactor,
  });

  ThemeControlModel copyWith({
    bool? isDarkMode,
    bool? isHighContrast,
    double? textScaleFactor,
  }) {
    return ThemeControlModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isHighContrast: isHighContrast ?? this.isHighContrast,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeControlModel &&
        other.isDarkMode == isDarkMode &&
        other.isHighContrast == isHighContrast &&
        (other.textScaleFactor - textScaleFactor).abs() < 0.01;
  }

  @override
  int get hashCode {
    return Object.hash(isDarkMode, isHighContrast, textScaleFactor);
  }

  @override
  String toString() {
    return 'ThemeControlModel(isDarkMode: $isDarkMode, isHighContrast: $isHighContrast, textScaleFactor: $textScaleFactor)';
  }
}
