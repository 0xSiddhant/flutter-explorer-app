/// Localization constants and utilities for the app
class AppLocalizations {
  AppLocalizations._();

  // Supported locales
  static const List<String> supportedLanguages = [
    'en',
    'es',
    'fr',
    'de',
    'ar',
    'ja',
  ];

  static const List<String> supportedLanguageNames = [
    'English',
    'Spanish',
    'French',
    'German',
    'Arabic',
    'Japanese',
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
      'theming': 'Theming',
      'method_channel': 'Method Channel',
      'native_communication': 'Native Communication',
      'isolates': 'Isolates',
      'background_tasks': 'Background Tasks',
      'localization': 'Localization',
      'internationalization': 'Internationalization',
      'semantic_ui': 'Semantic UI',
      'accessibility': 'Accessibility',

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
      'accessibility_settings': 'Accessibility',
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
      'file_management': 'File Management',
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

      // Advanced Processing
      'advanced_processing': 'Advanced Processing',
      'download_image': 'Download Image',
      'process_image': 'Process Image',
      'generate_thumbnail': 'Generate Thumbnail',
      'process_text_file': 'Process Text File',
      'generate_dataset': 'Generate Dataset',
      'analyze_data': 'Analyze Data',
      'perform_clustering': 'Perform Clustering',
      'compress_data': 'Compress Data',
      'processing': 'Processing...',
      'result': 'Result',
      'time': 'Time',
      'analysis': 'Analysis',
      'generated_records': 'Generated records',

      // Background Tasks
      'matrix_multiplication': 'Matrix Multiplication',
      'sort_large_array': 'Sort Large Array',
      'complex_calculation': 'Complex Calculation',
      'calculating': 'Calculating...',
      'first_10': 'First 10',

      // Navigation Analytics
      'navigation_analytics': 'Navigation Analytics',
      'no_analytics_available': 'No analytics available',
      'no_screen_visits': 'No screen visits recorded',
      'no_navigation_history': 'No navigation history',
      'navigation_history_cleared': 'Navigation history cleared',

      // Lifecycle Management
      'lifecycle_management': 'Lifecycle Management',
      'clear_all': 'Clear All',
      'close': 'Close',

      // Detail Screen
      'detail': 'Detail',

      // UI Elements
      'elevated_button': 'Elevated Button',
      'outlined_button': 'Outlined Button',
      'checkbox': 'Checkbox',
      'radio': 'Radio',
      'primary_action': 'Primary Action',
      'tap_to_navigate': 'Tap to navigate to',
      'navigating_to': 'Navigating to',

      // About Section
      'app_version_info': 'Flutter Core Features Demo v1.0.0',
      'app_description':
          'This app demonstrates various Flutter core features including:',
      'feature_navigation': '• Navigation and Routing',
      'feature_theme': '• Theme Management',
      'feature_method_channels': '• Method Channels',
      'feature_isolates': '• Isolates',
      'feature_localization': '• Localization',
      'feature_semantic_ui': '• Semantic UI',
      'feature_file_storage': '• File Storage',

      // File Management
      'create_sample_files': 'Create Sample Files',

      // Additional UI Strings
      'navigation_number': 'Navigation',
      'current_scale': 'Current scale:',
      'switch_between_rtl_ltr': 'Switch between RTL and LTR',
      'enable_voice_feedback_for_ui': 'Enable voice feedback for UI elements',
      'increase_text_size_for_readability':
          'Increase text size for better readability',
      'primary_action_button': 'Primary action button',
      'double_tap_to_perform_action': 'Double tap to perform the main action',
      'flutter_logo_description':
          'Flutter logo showing the Flutter framework mascot',
      'tab_navigation': 'Tab navigation with',
      'tabs': 'tabs',
      'tab': 'tab',
      'contact_form': 'Contact form',
      'name_input_field': 'Name input field',
      'email_input_field': 'Email input field',
      'list_of_items': 'List of items',
      'first_item': 'First item',
      'first_item_description': 'This is the first item in the list',
      'second_item': 'Second item',
      'second_item_description': 'This is the second item in the list',
      'third_item': 'Third item',
      'third_item_description': 'This is the third item in the list',
      'active_accessibility_features': 'Active Accessibility Features',
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
      'native_communication': 'Comunicación Nativa',
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

      // Advanced Processing
      'advanced_processing': 'Procesamiento Avanzado',
      'download_image': 'Descargar Imagen',
      'process_image': 'Procesar Imagen',
      'generate_thumbnail': 'Generar Miniatura',
      'process_text_file': 'Procesar Archivo de Texto',
      'generate_dataset': 'Generar Conjunto de Datos',
      'analyze_data': 'Analizar Datos',
      'perform_clustering': 'Realizar Agrupación',
      'compress_data': 'Comprimir Datos',
      'processing': 'Procesando...',
      'result': 'Resultado',
      'time': 'Tiempo',
      'analysis': 'Análisis',
      'generated_records': 'Registros generados',

      // Background Tasks
      'matrix_multiplication': 'Multiplicación de Matrices',
      'sort_large_array': 'Ordenar Array Grande',
      'complex_calculation': 'Cálculo Complejo',
      'calculating': 'Calculando...',
      'first_10': 'Primeros 10',

      // Navigation Analytics
      'navigation_analytics': 'Análisis de Navegación',
      'no_analytics_available': 'No hay análisis disponibles',
      'no_screen_visits': 'No se registraron visitas a pantallas',
      'no_navigation_history': 'No hay historial de navegación',
      'navigation_history_cleared': 'Historial de navegación borrado',

      // Lifecycle Management
      'lifecycle_management': 'Gestión del Ciclo de Vida',
      'clear_all': 'Borrar Todo',
      'close': 'Cerrar',

      // Detail Screen
      'detail': 'Detalle',

      // UI Elements
      'elevated_button': 'Botón Elevado',
      'outlined_button': 'Botón Contorneado',
      'checkbox': 'Casilla de Verificación',
      'radio': 'Botón de Radio',
      'primary_action': 'Acción Principal',
      'tap_to_navigate': 'Toca para navegar a',
      'navigating_to': 'Navegando a',

      // About Section
      'app_version_info':
          'Demo de Características Principales de Flutter v1.0.0',
      'app_description':
          'Esta aplicación demuestra varias características principales de Flutter incluyendo:',
      'feature_navigation': '• Navegación y Enrutamiento',
      'feature_theme': '• Gestión de Temas',
      'feature_method_channels': '• Canales de Método',
      'feature_isolates': '• Aislados',
      'feature_localization': '• Localización',
      'feature_semantic_ui': '• UI Semántica',
      'feature_file_storage': '• Almacenamiento de Archivos',

      // File Management
      'create_sample_files': 'Crear Archivos de Ejemplo',

      // Additional UI Strings
      'navigation_number': 'Navegación',
      'current_scale': 'Escala actual:',
      'switch_between_rtl_ltr': 'Cambiar entre RTL y LTR',
      'enable_voice_feedback_for_ui':
          'Habilitar retroalimentación de voz para elementos de UI',
      'increase_text_size_for_readability':
          'Aumentar tamaño de texto para mejor legibilidad',
      'primary_action_button': 'Botón de acción principal',
      'double_tap_to_perform_action':
          'Doble toque para realizar la acción principal',
      'flutter_logo_description':
          'Logo de Flutter mostrando la mascota del framework',
      'tab_navigation': 'Navegación de pestañas con',
      'tabs': 'pestañas',
      'tab': 'pestaña',
      'contact_form': 'Formulario de contacto',
      'name_input_field': 'Campo de entrada de nombre',
      'email_input_field': 'Campo de entrada de correo electrónico',
      'list_of_items': 'Lista de elementos',
      'first_item': 'Primer elemento',
      'first_item_description': 'Este es el primer elemento de la lista',
      'second_item': 'Segundo elemento',
      'second_item_description': 'Este es el segundo elemento de la lista',
      'third_item': 'Tercer elemento',
      'third_item_description': 'Este es el tercer elemento de la lista',
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
      'native_communication': 'Communication Native',
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

      // Advanced Processing
      'advanced_processing': 'Traitement Avancé',
      'download_image': 'Télécharger l\'Image',
      'process_image': 'Traiter l\'Image',
      'generate_thumbnail': 'Générer la Miniature',
      'process_text_file': 'Traiter le Fichier Texte',
      'generate_dataset': 'Générer l\'Ensemble de Données',
      'analyze_data': 'Analyser les Données',
      'perform_clustering': 'Effectuer le Clustering',
      'compress_data': 'Compresser les Données',
      'processing': 'Traitement...',
      'result': 'Résultat',
      'time': 'Temps',
      'analysis': 'Analyse',
      'generated_records': 'Enregistrements générés',

      // Background Tasks
      'matrix_multiplication': 'Multiplication de Matrices',
      'sort_large_array': 'Trier le Grand Tableau',
      'complex_calculation': 'Calcul Complexe',
      'calculating': 'Calcul...',
      'first_10': 'Premiers 10',

      // Navigation Analytics
      'navigation_analytics': 'Analytique de Navigation',
      'no_analytics_available': 'Aucune analytique disponible',
      'no_screen_visits': 'Aucune visite d\'écran enregistrée',
      'no_navigation_history': 'Aucun historique de navigation',
      'navigation_history_cleared': 'Historique de navigation effacé',

      // Lifecycle Management
      'lifecycle_management': 'Gestion du Cycle de Vie',
      'clear_all': 'Tout Effacer',
      'close': 'Fermer',

      // Detail Screen
      'detail': 'Détail',

      // UI Elements
      'elevated_button': 'Bouton Élevé',
      'outlined_button': 'Bouton Contourné',
      'checkbox': 'Case à Cocher',
      'radio': 'Bouton Radio',
      'primary_action': 'Action Principale',
      'tap_to_navigate': 'Appuyez pour naviguer vers',
      'navigating_to': 'Navigation vers',

      // About Section
      'app_version_info':
          'Démo des Fonctionnalités Principales de Flutter v1.0.0',
      'app_description':
          'Cette application démontre diverses fonctionnalités principales de Flutter incluant:',
      'feature_navigation': '• Navigation et Routage',
      'feature_theme': '• Gestion des Thèmes',
      'feature_method_channels': '• Canaux de Méthode',
      'feature_isolates': '• Isolats',
      'feature_localization': '• Localisation',
      'feature_semantic_ui': '• UI Sémantique',
      'feature_file_storage': '• Stockage de Fichiers',

      // File Management
      'create_sample_files': 'Créer des Fichiers d\'Exemple',

      // Additional UI Strings
      'navigation_number': 'Navigation',
      'current_scale': 'Échelle actuelle:',
      'switch_between_rtl_ltr': 'Basculer entre RTL et LTR',
      'enable_voice_feedback_for_ui':
          'Activer la rétroaction vocale pour les éléments UI',
      'increase_text_size_for_readability':
          'Augmenter la taille du texte pour une meilleure lisibilité',
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
      'native_communication': 'Native Kommunikation',
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

      // Advanced Processing
      'advanced_processing': 'Erweiterte Verarbeitung',
      'download_image': 'Bild Herunterladen',
      'process_image': 'Bild Verarbeiten',
      'generate_thumbnail': 'Vorschaubild Generieren',
      'process_text_file': 'Textdatei Verarbeiten',
      'generate_dataset': 'Datensatz Generieren',
      'analyze_data': 'Daten Analysieren',
      'perform_clustering': 'Clustering Durchführen',
      'compress_data': 'Daten Komprimieren',
      'processing': 'Verarbeitung...',
      'result': 'Ergebnis',
      'time': 'Zeit',
      'analysis': 'Analyse',
      'generated_records': 'Generierte Datensätze',

      // Background Tasks
      'matrix_multiplication': 'Matrix-Multiplikation',
      'sort_large_array': 'Großes Array Sortieren',
      'complex_calculation': 'Komplexe Berechnung',
      'calculating': 'Berechnung...',
      'first_10': 'Erste 10',

      // Navigation Analytics
      'navigation_analytics': 'Navigations-Analytik',
      'no_analytics_available': 'Keine Analytik verfügbar',
      'no_screen_visits': 'Keine Bildschirmbesuche aufgezeichnet',
      'no_navigation_history': 'Keine Navigationshistorie',
      'navigation_history_cleared': 'Navigationshistorie gelöscht',

      // Lifecycle Management
      'lifecycle_management': 'Lebenszyklus-Verwaltung',
      'clear_all': 'Alles Löschen',
      'close': 'Schließen',

      // Detail Screen
      'detail': 'Detail',

      // UI Elements
      'elevated_button': 'Erhöhter Button',
      'outlined_button': 'Umrandeter Button',
      'checkbox': 'Kontrollkästchen',
      'radio': 'Radio-Button',
      'primary_action': 'Primäre Aktion',
      'tap_to_navigate': 'Tippen Sie, um zu navigieren zu',
      'navigating_to': 'Navigation zu',

      // About Section
      'app_version_info': 'Flutter Core Features Demo v1.0.0',
      'app_description':
          'Diese App demonstriert verschiedene Flutter-Kernfunktionen einschließlich:',
      'feature_navigation': '• Navigation und Routing',
      'feature_theme': '• Themenverwaltung',
      'feature_method_channels': '• Methodenkanäle',
      'feature_isolates': '• Isolate',
      'feature_localization': '• Lokalisierung',
      'feature_semantic_ui': '• Semantische UI',
      'feature_file_storage': '• Dateispeicher',

      // File Management
      'create_sample_files': 'Beispieldateien Erstellen',

      // Additional UI Strings
      'navigation_number': 'Navigation',
      'current_scale': 'Aktuelle Skalierung:',
      'switch_between_rtl_ltr': 'Zwischen RTL und LTR wechseln',
      'enable_voice_feedback_for_ui':
          'Sprachrückmeldung für UI-Elemente aktivieren',
      'increase_text_size_for_readability':
          'Textgröße für bessere Lesbarkeit erhöhen',
    },
    'ar': {
      // Common
      'app_title': 'عرض ميزات Flutter الأساسية',
      'ok': 'موافق',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تعديل',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجح',

      // Navigation
      'home': 'الرئيسية',
      'settings': 'الإعدادات',
      'navigation': 'التنقل',
      'back': 'رجوع',
      'next': 'التالي',
      'previous': 'السابق',

      // Features
      'theme': 'المظهر',
      'theming': 'المظهر',
      'method_channel': 'قناة الطريقة',
      'native_communication': 'التواصل الأصلي',
      'isolates': 'العزلات',
      'background_tasks': 'المهام الخلفية',
      'localization': 'التوطين',
      'internationalization': 'التدويل',
      'semantic_ui': 'واجهة المستخدم الدلالية',
      'accessibility': 'إمكانية الوصول',

      // Theme
      'dark_mode': 'الوضع المظلم',
      'light_mode': 'الوضع الفاتح',
      'high_contrast': 'تباين عالي',
      'text_scale': 'مقياس النص',
      'theme_controls': 'أدوات التحكم في المظهر',
      'theme_preview': 'معاينة المظهر',
      'current_theme_info': 'معلومات المظهر الحالي',

      // Method Channel
      'device_info': 'معلومات الجهاز',
      'battery_level': 'مستوى البطارية',
      'native_method_calls': 'استدعاءات الطريقة الأصلية',
      'get_device_info': 'الحصول على معلومات الجهاز',
      'get_battery_level': 'الحصول على مستوى البطارية',
      'show_native_dialog': 'عرض مربع حوار أصلي',
      'vibrate': 'اهتزاز',
      'last_method_call': 'آخر استدعاء طريقة',

      // Isolates
      'calculations': 'الحسابات',
      'progress': 'التقدم',
      'results': 'النتائج',
      'fibonacci_ui_thread': 'فيبوناتشي (خيط واجهة المستخدم)',
      'fibonacci_isolate': 'فيبوناتشي (عزلة)',
      'find_prime_numbers': 'البحث عن الأعداد الأولية',
      'calculate_pi': 'حساب باي',
      'calculation_time': 'وقت الحساب',
      'prime_numbers_found': 'الأعداد الأولية الموجودة',

      // Localization
      'language': 'اللغة',
      'select_language': 'اختر اللغة',
      'current_time': 'الوقت الحالي',
      'date_format': 'تنسيق التاريخ',
      'number_format': 'تنسيق الرقم',
      'currency_format': 'تنسيق العملة',
      'formatting_examples': 'أمثلة التنسيق',
      'core_features': 'الميزات الأساسية',
      'internationalization_description':
          'هذا التطبيق يوضح ميزات Flutter الأساسية المختلفة بما في ذلك دعم التوطين.',

      // Semantic UI
      'accessibility_controls': 'أدوات التحكم في إمكانية الوصول',
      'screen_reader_mode': 'وضع قارئ الشاشة',
      'large_text': 'نص كبير',
      'semantic_ui_examples': 'أمثلة واجهة المستخدم الدلالية',
      'semantic_button': 'زر دلالي',
      'semantic_image': 'صورة دلالية',
      'semantic_tab_bar': 'شريط التبويب الدلالي',
      'semantic_form': 'نموذج دلالي',
      'semantic_list': 'قائمة دلالية',
      'last_action': 'آخر إجراء',

      // Settings
      'appearance': 'المظهر',
      'accessibility_settings': 'إمكانية الوصول',
      'about': 'حول',
      'app_version': 'إصدار التطبيق',
      'screen_reader': 'قارئ الشاشة',
      'large_touch_targets': 'أهداف اللمس الكبيرة',
      'enable_voice_feedback': 'تمكين التغذية الراجعة الصوتية',
      'increase_button_sizes': 'زيادة أحجام الأزرار',
      'switch_between_light_and_dark_themes':
          'التبديل بين السمات الفاتحة والداكنة',
      'increase_contrast_for_better_visibility': 'زيادة التباين لرؤية أفضل',
      'increase_text_size_for_better_readability': 'زيادة حجم النص لقراءة أفضل',

      // File Storage
      'file_management': 'إدارة الملفات',
      'save_file': 'حفظ الملف',
      'load_file': 'تحميل الملف',
      'delete_file': 'حذف الملف',
      'file_name': 'اسم الملف',
      'file_content': 'محتوى الملف',
      'file_saved_successfully': 'تم حفظ الملف بنجاح',
      'file_loaded_successfully': 'تم تحميل الملف بنجاح',
      'file_deleted_successfully': 'تم حذف الملف بنجاح',
      'error_saving_file': 'خطأ في حفظ الملف',
      'error_loading_file': 'خطأ في تحميل الملف',
      'error_deleting_file': 'خطأ في حذف الملف',
      'no_files_found': 'لم يتم العثور على ملفات',
      'enter_file_name': 'أدخل اسم الملف',
      'enter_file_content': 'أدخل محتوى الملف',

      // Advanced Processing
      'advanced_processing': 'المعالجة المتقدمة',
      'download_image': 'تحميل الصورة',
      'process_image': 'معالجة الصورة',
      'generate_thumbnail': 'إنشاء صورة مصغرة',
      'process_text_file': 'معالجة ملف النص',
      'generate_dataset': 'إنشاء مجموعة بيانات',
      'analyze_data': 'تحليل البيانات',
      'perform_clustering': 'تنفيذ التجميع',
      'compress_data': 'ضغط البيانات',
      'processing': 'جاري المعالجة...',
      'result': 'النتيجة',
      'time': 'الوقت',
      'analysis': 'التحليل',
      'generated_records': 'السجلات المُنشأة',

      // Background Tasks
      'matrix_multiplication': 'ضرب المصفوفات',
      'sort_large_array': 'ترتيب المصفوفة الكبيرة',
      'complex_calculation': 'الحساب المعقد',
      'calculating': 'جاري الحساب...',
      'first_10': 'الأول 10',

      // Navigation Analytics
      'navigation_analytics': 'تحليلات التنقل',
      'no_analytics_available': 'لا توجد تحليلات متاحة',
      'no_screen_visits': 'لا توجد زيارات للشاشة مسجلة',
      'no_navigation_history': 'لا يوجد سجل تنقل',
      'navigation_history_cleared': 'تم مسح سجل التنقل',

      // Lifecycle Management
      'lifecycle_management': 'إدارة دورة الحياة',
      'clear_all': 'مسح الكل',
      'close': 'إغلاق',

      // Detail Screen
      'detail': 'التفاصيل',

      // UI Elements
      'elevated_button': 'زر مرتفع',
      'outlined_button': 'زر محدد',
      'checkbox': 'صندوق اختيار',
      'radio': 'زر راديو',
      'primary_action': 'الإجراء الأساسي',
      'tap_to_navigate': 'انقر للانتقال إلى',
      'navigating_to': 'الانتقال إلى',

      // About Section
      'app_version_info': 'عرض ميزات Flutter الأساسية v1.0.0',
      'app_description':
          'هذا التطبيق يوضح ميزات Flutter الأساسية المختلفة بما في ذلك:',
      'feature_navigation': '• التنقل والتوجيه',
      'feature_theme': '• إدارة المظهر',
      'feature_method_channels': '• قنوات الطريقة',
      'feature_isolates': '• العزلات',
      'feature_localization': '• التوطين',
      'feature_semantic_ui': '• واجهة المستخدم الدلالية',
      'feature_file_storage': '• تخزين الملفات',

      // File Management
      'create_sample_files': 'إنشاء ملفات نموذجية',

      // Additional UI Strings
      'navigation_number': 'التنقل',
      'current_scale': 'المقياس الحالي:',
      'switch_between_rtl_ltr': 'التبديل بين RTL و LTR',
      'enable_voice_feedback_for_ui':
          'تمكين التغذية الراجعة الصوتية لعناصر واجهة المستخدم',
      'increase_text_size_for_readability': 'زيادة حجم النص لقراءة أفضل',

      // RTL Support
      'text_direction': 'اتجاه النص',
      'rtl_description':
          'تبديل بين اتجاه النص من اليمين إلى اليسار ومن اليسار إلى اليمين',
    },
    'ja': {
      // Common
      'app_title': 'Flutterコア機能デモ',
      'ok': 'OK',
      'cancel': 'キャンセル',
      'save': '保存',
      'delete': '削除',
      'edit': '編集',
      'loading': '読み込み中...',
      'error': 'エラー',
      'success': '成功',

      // Navigation
      'home': 'ホーム',
      'settings': '設定',
      'navigation': 'ナビゲーション',
      'back': '戻る',
      'next': '次へ',
      'previous': '前へ',

      // Features
      'theme': 'テーマ',
      'theming': 'テーマ',
      'method_channel': 'メソッドチャンネル',
      'native_communication': 'ネイティブ通信',
      'isolates': 'アイソレート',
      'background_tasks': 'バックグラウンドタスク',
      'localization': 'ローカライゼーション',
      'internationalization': '国際化',
      'semantic_ui': 'セマンティックUI',
      'accessibility': 'アクセシビリティ',

      // Theme
      'dark_mode': 'ダークモード',
      'light_mode': 'ライトモード',
      'high_contrast': 'ハイコントラスト',
      'text_scale': 'テキストスケール',
      'theme_controls': 'テーマコントロール',
      'theme_preview': 'テーマプレビュー',
      'current_theme_info': '現在のテーマ情報',

      // Method Channel
      'device_info': 'デバイス情報',
      'battery_level': 'バッテリーレベル',
      'native_method_calls': 'ネイティブメソッド呼び出し',
      'get_device_info': 'デバイス情報を取得',
      'get_battery_level': 'バッテリーレベルを取得',
      'show_native_dialog': 'ネイティブダイアログを表示',
      'vibrate': '振動',
      'last_method_call': '最後のメソッド呼び出し',

      // Isolates
      'calculations': '計算',
      'progress': '進捗',
      'results': '結果',
      'fibonacci_ui_thread': 'フィボナッチ（UIスレッド）',
      'fibonacci_isolate': 'フィボナッチ（アイソレート）',
      'find_prime_numbers': '素数を見つける',
      'calculate_pi': '円周率を計算',
      'calculation_time': '計算時間',
      'prime_numbers_found': '見つかった素数',

      // Localization
      'language': '言語',
      'select_language': '言語を選択',
      'current_time': '現在時刻',
      'date_format': '日付形式',
      'number_format': '数値形式',
      'currency_format': '通貨形式',
      'formatting_examples': 'フォーマット例',
      'core_features': 'コア機能',
      'internationalization_description':
          'このアプリは、ローカライゼーションサポートを含むFlutterの様々なコア機能をデモンストレーションします。',

      // Semantic UI
      'accessibility_controls': 'アクセシビリティコントロール',
      'screen_reader_mode': 'スクリーンリーダーモード',
      'large_text': '大きなテキスト',
      'semantic_ui_examples': 'セマンティックUI例',
      'semantic_button': 'セマンティックボタン',
      'semantic_image': 'セマンティック画像',
      'semantic_tab_bar': 'セマンティックタブバー',
      'semantic_form': 'セマンティックフォーム',
      'semantic_list': 'セマンティックリスト',
      'last_action': '最後のアクション',

      // Settings
      'appearance': '外観',
      'accessibility_settings': 'アクセシビリティ',
      'about': 'について',
      'app_version': 'アプリバージョン',
      'screen_reader': 'スクリーンリーダー',
      'large_touch_targets': '大きなタッチターゲット',
      'enable_voice_feedback': '音声フィードバックを有効にする',
      'increase_button_sizes': 'ボタンサイズを大きくする',
      'switch_between_light_and_dark_themes': 'ライトテーマとダークテーマを切り替える',
      'increase_contrast_for_better_visibility': '視認性向上のためコントラストを上げる',
      'increase_text_size_for_better_readability': '可読性向上のためテキストサイズを大きくする',

      // File Storage
      'file_management': 'ファイル管理',
      'save_file': 'ファイルを保存',
      'load_file': 'ファイルを読み込み',
      'delete_file': 'ファイルを削除',
      'file_name': 'ファイル名',
      'file_content': 'ファイル内容',
      'file_saved_successfully': 'ファイルが正常に保存されました',
      'file_loaded_successfully': 'ファイルが正常に読み込まれました',
      'file_deleted_successfully': 'ファイルが正常に削除されました',
      'error_saving_file': 'ファイル保存エラー',
      'error_loading_file': 'ファイル読み込みエラー',
      'error_deleting_file': 'ファイル削除エラー',
      'no_files_found': 'ファイルが見つかりません',
      'enter_file_name': 'ファイル名を入力',
      'enter_file_content': 'ファイル内容を入力',

      // Advanced Processing
      'advanced_processing': '高度な処理',
      'download_image': '画像をダウンロード',
      'process_image': '画像を処理',
      'generate_thumbnail': 'サムネイルを生成',
      'process_text_file': 'テキストファイルを処理',
      'generate_dataset': 'データセットを生成',
      'analyze_data': 'データを分析',
      'perform_clustering': 'クラスタリングを実行',
      'compress_data': 'データを圧縮',
      'processing': '処理中...',
      'result': '結果',
      'time': '時間',
      'analysis': '分析',
      'generated_records': '生成されたレコード',

      // Background Tasks
      'matrix_multiplication': '行列乗算',
      'sort_large_array': '大きな配列をソート',
      'complex_calculation': '複雑な計算',
      'calculating': '計算中...',
      'first_10': '最初の10',

      // Navigation Analytics
      'navigation_analytics': 'ナビゲーション分析',
      'no_analytics_available': '分析データがありません',
      'no_screen_visits': '画面訪問記録がありません',
      'no_navigation_history': 'ナビゲーション履歴がありません',
      'navigation_history_cleared': 'ナビゲーション履歴がクリアされました',

      // Lifecycle Management
      'lifecycle_management': 'ライフサイクル管理',
      'clear_all': 'すべてクリア',
      'close': '閉じる',

      // Detail Screen
      'detail': '詳細',

      // UI Elements
      'elevated_button': 'エレベーテッドボタン',
      'outlined_button': 'アウトラインボタン',
      'checkbox': 'チェックボックス',
      'radio': 'ラジオボタン',
      'primary_action': 'プライマリアクション',
      'tap_to_navigate': 'タップしてナビゲート',
      'navigating_to': 'ナビゲート中',

      // About Section
      'app_version_info': 'Flutterコア機能デモ v1.0.0',
      'app_description': 'このアプリは、Flutterの様々なコア機能をデモンストレーションします：',
      'feature_navigation': '• ナビゲーションとルーティング',
      'feature_theme': '• テーマ管理',
      'feature_method_channels': '• メソッドチャンネル',
      'feature_isolates': '• アイソレート',
      'feature_localization': '• ローカライゼーション',
      'feature_semantic_ui': '• セマンティックUI',
      'feature_file_storage': '• ファイルストレージ',

      // File Management
      'create_sample_files': 'サンプルファイルを作成',

      // Additional UI Strings
      'navigation_number': 'ナビゲーション',
      'current_scale': '現在のスケール:',
      'switch_between_rtl_ltr': 'RTLとLTRを切り替え',
      'enable_voice_feedback_for_ui': 'UI要素の音声フィードバックを有効にする',
      'increase_text_size_for_readability': '可読性向上のためテキストサイズを大きくする',

      // RTL Support
      'text_direction': 'テキスト方向',
      'rtl_description': '右から左、左から右のテキスト方向を切り替える',
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
      case 'ar':
        return '${date.day}/${date.month}/${date.year}';
      case 'ja':
        return '${date.year}年$date.month月$date.day日';
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
      case 'ar':
        return '$hour:$minute';
      case 'ja':
        return '$hour時$minute分';
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
      case 'ar':
        return '1,234,567.89';
      case 'ja':
        return '1,234,567.89';
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
      case 'ar':
        return '1,234,567.89 ر.س';
      case 'ja':
        return '¥1,234,567.89';
      default:
        return '\$1,234,567.89';
    }
  }
}
