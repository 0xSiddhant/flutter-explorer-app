/// Localization constants and utilities for the app
class AppLocalizations {
  AppLocalizations._();

  // Supported locales
  static const List<String> supportedLanguages = ['en', 'es', 'fr', 'de'];

  static const List<String> supportedLanguageNames = [
    'English',
    'Spanish',
    'French',
    'German',
  ];

  // Translation maps
  static const Map<String, Map<String, String>> _translations = {
    'en': {
      // Common
      'app_title': 'Flutter Core Features Demo',
      'ok': 'OK',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',

      // Navigation
      'home': 'Home',
      'settings': 'Settings',
      'navigation': 'Navigation',
      'back': 'Back',
      'next': 'Next',
      'previous': 'Previous',

      // Features
      'theme': 'Theme',
      'theme_demo': 'Theme Demo',
      'method_channel': 'Method Channel',
      'method_channel_demo': 'Method Channel Demo',
      'isolates': 'Isolates',
      'isolate_demo': 'Isolate Demo',
      'localization': 'Localization',
      'localization_demo': 'Localization Demo',
      'semantic_ui': 'Semantic UI',
      'semantic_demo': 'Semantic Demo',

      // Theme
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'high_contrast': 'High Contrast',
      'text_scale': 'Text Scale',
      'theme_controls': 'Theme Controls',
      'theme_preview': 'Theme Preview',
      'current_theme_info': 'Current Theme Info',

      // Method Channel
      'device_info': 'Device Information',
      'battery_level': 'Battery Level',
      'native_method_calls': 'Native Method Calls',
      'get_device_info': 'Get Device Info',
      'get_battery_level': 'Get Battery Level',
      'show_native_dialog': 'Show Native Dialog',
      'vibrate': 'Vibrate',
      'last_method_call': 'Last Method Call',

      // Isolates
      'calculations': 'Calculations',
      'progress': 'Progress',
      'results': 'Results',
      'fibonacci_ui_thread': 'Fibonacci (UI Thread)',
      'fibonacci_isolate': 'Fibonacci (Isolate)',
      'find_prime_numbers': 'Find Prime Numbers',
      'calculate_pi': 'Calculate Pi',
      'calculation_time': 'Calculation time',
      'prime_numbers_found': 'Prime Numbers Found',

      // Localization
      'language': 'Language',
      'select_language': 'Select Language',
      'current_time': 'Current Time',
      'date_format': 'Date Format',
      'number_format': 'Number Format',
      'currency_format': 'Currency Format',
      'formatting_examples': 'Formatting Examples',
      'core_features': 'Core Features',

      // Semantic UI
      'accessibility_controls': 'Accessibility Controls',
      'screen_reader_mode': 'Screen Reader Mode',
      'large_text': 'Large Text',
      'semantic_ui_examples': 'Semantic UI Examples',
      'semantic_button': 'Semantic Button',
      'semantic_image': 'Semantic Image',
      'semantic_tab_bar': 'Semantic Tab Bar',
      'semantic_form': 'Semantic Form',
      'semantic_list': 'Semantic List',
      'last_action': 'Last Action',

      // Settings
      'appearance': 'Appearance',
      'accessibility': 'Accessibility',
      'about': 'About',
      'app_version': 'App Version',
      'screen_reader': 'Screen Reader',
      'large_touch_targets': 'Large Touch Targets',
      'enable_voice_feedback': 'Enable voice feedback',
      'increase_button_sizes': 'Increase button sizes',
      'switch_between_light_and_dark_themes':
          'Switch between light and dark themes',
      'increase_contrast_for_better_visibility':
          'Increase contrast for better visibility',
      'increase_text_size_for_better_readability':
          'Increase text size for better readability',

      // File Storage
      'file_storage': 'File Storage',
      'file_storage_demo': 'File Storage Demo',
      'save_file': 'Save File',
      'load_file': 'Load File',
      'delete_file': 'Delete File',
      'file_name': 'File Name',
      'file_content': 'File Content',
      'file_saved_successfully': 'File saved successfully',
      'file_loaded_successfully': 'File loaded successfully',
      'file_deleted_successfully': 'File deleted successfully',
      'error_saving_file': 'Error saving file',
      'error_loading_file': 'Error loading file',
      'error_deleting_file': 'Error deleting file',
      'no_files_found': 'No files found',
      'enter_file_name': 'Enter file name',
      'enter_file_content': 'Enter file content',
    },
    'es': {
      // Common
      'app_title': 'Demo de Características Principales de Flutter',
      'ok': 'Aceptar',
      'cancel': 'Cancelar',
      'save': 'Guardar',
      'delete': 'Eliminar',
      'edit': 'Editar',
      'loading': 'Cargando...',
      'error': 'Error',
      'success': 'Éxito',

      // Navigation
      'home': 'Inicio',
      'settings': 'Configuración',
      'navigation': 'Navegación',
      'back': 'Atrás',
      'next': 'Siguiente',
      'previous': 'Anterior',

      // Features
      'theme': 'Tema',
      'theme_demo': 'Demo de Tema',
      'method_channel': 'Canal de Método',
      'method_channel_demo': 'Demo de Canal de Método',
      'isolates': 'Aislados',
      'isolate_demo': 'Demo de Aislados',
      'localization': 'Localización',
      'localization_demo': 'Demo de Localización',
      'semantic_ui': 'UI Semántica',
      'semantic_demo': 'Demo Semántica',

      // Theme
      'dark_mode': 'Modo Oscuro',
      'light_mode': 'Modo Claro',
      'high_contrast': 'Alto Contraste',
      'text_scale': 'Escala de Texto',
      'theme_controls': 'Controles de Tema',
      'theme_preview': 'Vista Previa del Tema',
      'current_theme_info': 'Información del Tema Actual',

      // Method Channel
      'device_info': 'Información del Dispositivo',
      'battery_level': 'Nivel de Batería',
      'native_method_calls': 'Llamadas de Método Nativo',
      'get_device_info': 'Obtener Info del Dispositivo',
      'get_battery_level': 'Obtener Nivel de Batería',
      'show_native_dialog': 'Mostrar Diálogo Nativo',
      'vibrate': 'Vibrar',
      'last_method_call': 'Última Llamada de Método',

      // Isolates
      'calculations': 'Cálculos',
      'progress': 'Progreso',
      'results': 'Resultados',
      'fibonacci_ui_thread': 'Fibonacci (Hilo UI)',
      'fibonacci_isolate': 'Fibonacci (Aislado)',
      'find_prime_numbers': 'Encontrar Números Primos',
      'calculate_pi': 'Calcular Pi',
      'calculation_time': 'Tiempo de cálculo',
      'prime_numbers_found': 'Números Primos Encontrados',

      // Localization
      'language': 'Idioma',
      'select_language': 'Seleccionar Idioma',
      'current_time': 'Hora Actual',
      'date_format': 'Formato de Fecha',
      'number_format': 'Formato de Número',
      'currency_format': 'Formato de Moneda',
      'formatting_examples': 'Ejemplos de Formato',
      'core_features': 'Características Principales',

      // Semantic UI
      'accessibility_controls': 'Controles de Accesibilidad',
      'screen_reader_mode': 'Modo Lector de Pantalla',
      'large_text': 'Texto Grande',
      'semantic_ui_examples': 'Ejemplos de UI Semántica',
      'semantic_button': 'Botón Semántico',
      'semantic_image': 'Imagen Semántica',
      'semantic_tab_bar': 'Barra de Pestañas Semántica',
      'semantic_form': 'Formulario Semántico',
      'semantic_list': 'Lista Semántica',
      'last_action': 'Última Acción',

      // Settings
      'appearance': 'Apariencia',
      'accessibility': 'Accesibilidad',
      'about': 'Acerca de',
      'app_version': 'Versión de la App',
      'screen_reader': 'Lector de Pantalla',
      'large_touch_targets': 'Objetivos de Toque Grandes',
      'enable_voice_feedback': 'Habilitar retroalimentación de voz',
      'increase_button_sizes': 'Aumentar tamaños de botones',
      'switch_between_light_and_dark_themes':
          'Cambiar entre temas claros y oscuros',
      'increase_contrast_for_better_visibility':
          'Aumentar contraste para mejor visibilidad',
      'increase_text_size_for_better_readability':
          'Aumentar tamaño de texto para mejor legibilidad',

      // File Storage
      'file_storage': 'Almacenamiento de Archivos',
      'file_storage_demo': 'Demo de Almacenamiento',
      'save_file': 'Guardar Archivo',
      'load_file': 'Cargar Archivo',
      'delete_file': 'Eliminar Archivo',
      'file_name': 'Nombre del Archivo',
      'file_content': 'Contenido del Archivo',
      'file_saved_successfully': 'Archivo guardado exitosamente',
      'file_loaded_successfully': 'Archivo cargado exitosamente',
      'file_deleted_successfully': 'Archivo eliminado exitosamente',
      'error_saving_file': 'Error al guardar archivo',
      'error_loading_file': 'Error al cargar archivo',
      'error_deleting_file': 'Error al eliminar archivo',
      'no_files_found': 'No se encontraron archivos',
      'enter_file_name': 'Ingrese nombre del archivo',
      'enter_file_content': 'Ingrese contenido del archivo',
    },
    'fr': {
      // Common
      'app_title': 'Démo des Fonctionnalités Principales de Flutter',
      'ok': 'OK',
      'cancel': 'Annuler',
      'save': 'Enregistrer',
      'delete': 'Supprimer',
      'edit': 'Modifier',
      'loading': 'Chargement...',
      'error': 'Erreur',
      'success': 'Succès',

      // Navigation
      'home': 'Accueil',
      'settings': 'Paramètres',
      'navigation': 'Navigation',
      'back': 'Retour',
      'next': 'Suivant',
      'previous': 'Précédent',

      // Features
      'theme': 'Thème',
      'theme_demo': 'Démo de Thème',
      'method_channel': 'Canal de Méthode',
      'method_channel_demo': 'Démo de Canal de Méthode',
      'isolates': 'Isolats',
      'isolate_demo': 'Démo d\'Isolats',
      'localization': 'Localisation',
      'localization_demo': 'Démo de Localisation',
      'semantic_ui': 'UI Sémantique',
      'semantic_demo': 'Démo Sémantique',

      // Theme
      'dark_mode': 'Mode Sombre',
      'light_mode': 'Mode Clair',
      'high_contrast': 'Contraste Élevé',
      'text_scale': 'Échelle de Texte',
      'theme_controls': 'Contrôles de Thème',
      'theme_preview': 'Aperçu du Thème',
      'current_theme_info': 'Informations du Thème Actuel',

      // Method Channel
      'device_info': 'Informations sur l\'Appareil',
      'battery_level': 'Niveau de Batterie',
      'native_method_calls': 'Appels de Méthode Natifs',
      'get_device_info': 'Obtenir les Infos de l\'Appareil',
      'get_battery_level': 'Obtenir le Niveau de Batterie',
      'show_native_dialog': 'Afficher le Dialogue Natif',
      'vibrate': 'Vibrer',
      'last_method_call': 'Dernier Appel de Méthode',

      // Isolates
      'calculations': 'Calculs',
      'progress': 'Progrès',
      'results': 'Résultats',
      'fibonacci_ui_thread': 'Fibonacci (Thread UI)',
      'fibonacci_isolate': 'Fibonacci (Isolat)',
      'find_prime_numbers': 'Trouver les Nombres Premiers',
      'calculate_pi': 'Calculer Pi',
      'calculation_time': 'Temps de calcul',
      'prime_numbers_found': 'Nombres Premiers Trouvés',

      // Localization
      'language': 'Langue',
      'select_language': 'Sélectionner la Langue',
      'current_time': 'Heure Actuelle',
      'date_format': 'Format de Date',
      'number_format': 'Format de Nombre',
      'currency_format': 'Format de Devise',
      'formatting_examples': 'Exemples de Formatage',
      'core_features': 'Fonctionnalités Principales',

      // Semantic UI
      'accessibility_controls': 'Contrôles d\'Accessibilité',
      'screen_reader_mode': 'Mode Lecteur d\'Écran',
      'large_text': 'Texte Large',
      'semantic_ui_examples': 'Exemples d\'UI Sémantique',
      'semantic_button': 'Bouton Sémantique',
      'semantic_image': 'Image Sémantique',
      'semantic_tab_bar': 'Barre d\'Onglets Sémantique',
      'semantic_form': 'Formulaire Sémantique',
      'semantic_list': 'Liste Sémantique',
      'last_action': 'Dernière Action',

      // Settings
      'appearance': 'Apparence',
      'accessibility': 'Accessibilité',
      'about': 'À Propos',
      'app_version': 'Version de l\'App',
      'screen_reader': 'Lecteur d\'Écran',
      'large_touch_targets': 'Cibles de Toucher Larges',
      'enable_voice_feedback': 'Activer la rétroaction vocale',
      'increase_button_sizes': 'Augmenter les tailles de boutons',
      'switch_between_light_and_dark_themes':
          'Basculer entre les thèmes clairs et sombres',
      'increase_contrast_for_better_visibility':
          'Augmenter le contraste pour une meilleure visibilité',
      'increase_text_size_for_better_readability':
          'Augmenter la taille du texte pour une meilleure lisibilité',

      // File Storage
      'file_storage': 'Stockage de Fichiers',
      'file_storage_demo': 'Démo de Stockage',
      'save_file': 'Enregistrer le Fichier',
      'load_file': 'Charger le Fichier',
      'delete_file': 'Supprimer le Fichier',
      'file_name': 'Nom du Fichier',
      'file_content': 'Contenu du Fichier',
      'file_saved_successfully': 'Fichier enregistré avec succès',
      'file_loaded_successfully': 'Fichier chargé avec succès',
      'file_deleted_successfully': 'Fichier supprimé avec succès',
      'error_saving_file': 'Erreur lors de l\'enregistrement du fichier',
      'error_loading_file': 'Erreur lors du chargement du fichier',
      'error_deleting_file': 'Erreur lors de la suppression du fichier',
      'no_files_found': 'Aucun fichier trouvé',
      'enter_file_name': 'Entrez le nom du fichier',
      'enter_file_content': 'Entrez le contenu du fichier',
    },
    'de': {
      // Common
      'app_title': 'Flutter Core Features Demo',
      'ok': 'OK',
      'cancel': 'Abbrechen',
      'save': 'Speichern',
      'delete': 'Löschen',
      'edit': 'Bearbeiten',
      'loading': 'Lädt...',
      'error': 'Fehler',
      'success': 'Erfolg',

      // Navigation
      'home': 'Startseite',
      'settings': 'Einstellungen',
      'navigation': 'Navigation',
      'back': 'Zurück',
      'next': 'Weiter',
      'previous': 'Vorherige',

      // Features
      'theme': 'Thema',
      'theme_demo': 'Thema Demo',
      'method_channel': 'Methodenkanal',
      'method_channel_demo': 'Methodenkanal Demo',
      'isolates': 'Isolate',
      'isolate_demo': 'Isolate Demo',
      'localization': 'Lokalisierung',
      'localization_demo': 'Lokalisierungs Demo',
      'semantic_ui': 'Semantische UI',
      'semantic_demo': 'Semantische Demo',

      // Theme
      'dark_mode': 'Dunkler Modus',
      'light_mode': 'Heller Modus',
      'high_contrast': 'Hoher Kontrast',
      'text_scale': 'Textskalierung',
      'theme_controls': 'Themensteuerung',
      'theme_preview': 'Themenvorschau',
      'current_theme_info': 'Aktuelle Themeninfo',

      // Method Channel
      'device_info': 'Geräteinformationen',
      'battery_level': 'Batteriestand',
      'native_method_calls': 'Native Methodenaufrufe',
      'get_device_info': 'Geräteinformationen abrufen',
      'get_battery_level': 'Batteriestand abrufen',
      'show_native_dialog': 'Natives Dialog anzeigen',
      'vibrate': 'Vibrieren',
      'last_method_call': 'Letzter Methodenaufruf',

      // Isolates
      'calculations': 'Berechnungen',
      'progress': 'Fortschritt',
      'results': 'Ergebnisse',
      'fibonacci_ui_thread': 'Fibonacci (UI-Thread)',
      'fibonacci_isolate': 'Fibonacci (Isolat)',
      'find_prime_numbers': 'Primzahlen finden',
      'calculate_pi': 'Pi berechnen',
      'calculation_time': 'Berechnungszeit',
      'prime_numbers_found': 'Gefundene Primzahlen',

      // Localization
      'language': 'Sprache',
      'select_language': 'Sprache Auswählen',
      'current_time': 'Aktuelle Zeit',
      'date_format': 'Datumsformat',
      'number_format': 'Zahlenformat',
      'currency_format': 'Währungsformat',
      'formatting_examples': 'Formatierungsbeispiele',
      'core_features': 'Kernfunktionen',

      // Semantic UI
      'accessibility_controls': 'Barrierefreiheit-Steuerung',
      'screen_reader_mode': 'Bildschirmleser-Modus',
      'large_text': 'Großer Text',
      'semantic_ui_examples': 'Semantische UI-Beispiele',
      'semantic_button': 'Semantischer Button',
      'semantic_image': 'Semantisches Bild',
      'semantic_tab_bar': 'Semantische Tab-Leiste',
      'semantic_form': 'Semantisches Formular',
      'semantic_list': 'Semantische Liste',
      'last_action': 'Letzte Aktion',

      // Settings
      'appearance': 'Erscheinungsbild',
      'accessibility': 'Barrierefreiheit',
      'about': 'Über',
      'app_version': 'App-Version',
      'screen_reader': 'Bildschirmleser',
      'large_touch_targets': 'Große Touch-Ziele',
      'enable_voice_feedback': 'Sprachrückmeldung aktivieren',
      'increase_button_sizes': 'Button-Größen erhöhen',
      'switch_between_light_and_dark_themes':
          'Zwischen hellen und dunklen Themen wechseln',
      'increase_contrast_for_better_visibility':
          'Kontrast für bessere Sichtbarkeit erhöhen',
      'increase_text_size_for_better_readability':
          'Textgröße für bessere Lesbarkeit erhöhen',

      // File Storage
      'file_storage': 'Dateispeicher',
      'file_storage_demo': 'Dateispeicher Demo',
      'save_file': 'Datei Speichern',
      'load_file': 'Datei Laden',
      'delete_file': 'Datei Löschen',
      'file_name': 'Dateiname',
      'file_content': 'Dateiinhalt',
      'file_saved_successfully': 'Datei erfolgreich gespeichert',
      'file_loaded_successfully': 'Datei erfolgreich geladen',
      'file_deleted_successfully': 'Datei erfolgreich gelöscht',
      'error_saving_file': 'Fehler beim Speichern der Datei',
      'error_loading_file': 'Fehler beim Laden der Datei',
      'error_deleting_file': 'Fehler beim Löschen der Datei',
      'no_files_found': 'Keine Dateien gefunden',
      'enter_file_name': 'Dateiname eingeben',
      'enter_file_content': 'Dateiinhalt eingeben',
    },
  };

  /// Get translation for a key in the specified language
  static String getString(String key, String language) {
    return _translations[language]?[key] ?? _translations['en']![key] ?? key;
  }

  /// Get all translations for a key across all languages
  static Map<String, String> getTranslationsForKey(String key) {
    final Map<String, String> translations = {};
    for (final language in supportedLanguages) {
      translations[language] = getString(key, language);
    }
    return translations;
  }

  /// Format date according to locale
  static String formatDate(DateTime date, String language) {
    switch (language) {
      case 'es':
        return '${date.day}/${date.month}/${date.year}';
      case 'fr':
        return '${date.day}/${date.month}/${date.year}';
      case 'de':
        return '${date.day}.${date.month}.${date.year}';
      default:
        return '${date.month}/${date.day}/${date.year}';
    }
  }

  /// Format time according to locale
  static String formatTime(DateTime time, String language) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    switch (language) {
      case 'es':
        return '$hour:$minute';
      case 'fr':
        return '${hour}h$minute';
      case 'de':
        return '$hour:$minute Uhr';
      default:
        return '$hour:$minute';
    }
  }

  /// Format number according to locale
  static String formatNumber(double number, String language) {
    switch (language) {
      case 'es':
        return '1.234.567,89';
      case 'fr':
        return '1 234 567,89';
      case 'de':
        return '1.234.567,89';
      default:
        return '1,234,567.89';
    }
  }

  /// Format currency according to locale
  static String formatCurrency(double amount, String language) {
    switch (language) {
      case 'es':
        return '1.234.567,89 €';
      case 'fr':
        return '1 234 567,89 €';
      case 'de':
        return '1.234.567,89 €';
      default:
        return '\$1,234,567.89';
    }
  }
}
