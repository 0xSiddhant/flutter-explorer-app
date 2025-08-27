import 'package:flutter/material.dart';
import 'state_restoration_service.dart';

/// Mixin for adding state restoration support to screens
/// Provides easy integration with StateRestorationService
mixin AppRestorationMixin<T extends StatefulWidget> on State<T> {
  late final StateRestorationService _restorationService =
      StateRestorationService.instance;

  /// Get the restoration key for this screen
  String get restorationKey;

  /// Get the scroll restoration key for this screen
  String get scrollRestorationKey => '${restorationKey}_scroll';

  /// Get current scroll position for this screen
  double get currentScrollPosition =>
      _restorationService.getScrollPosition(scrollRestorationKey);

  /// Save scroll position for this screen
  void saveScrollPosition(double position) {
    _restorationService.updateScrollPosition(scrollRestorationKey, position);
  }

  /// Get app state for a specific key
  dynamic getAppState(String key) {
    return _restorationService.getAppState('${restorationKey}_$key');
  }

  /// Save app state for a specific key
  void saveAppState(String key, dynamic value) {
    _restorationService.updateAppState('${restorationKey}_$key', value);
  }

  /// Get all app state for this screen
  Map<String, dynamic> getScreenState() {
    final allState = _restorationService.appState;
    final screenState = <String, dynamic>{};

    for (final entry in allState.entries) {
      if (entry.key.startsWith('${restorationKey}_')) {
        final key = entry.key.substring('${restorationKey}_'.length);
        screenState[key] = entry.value;
      }
    }

    return screenState;
  }

  /// Save multiple app state values for this screen
  void saveScreenState(Map<String, dynamic> state) {
    for (final entry in state.entries) {
      saveAppState(entry.key, entry.value);
    }
  }

  /// Clear all state for this screen
  void clearScreenState() {
    final allState = _restorationService.appState;
    final keysToRemove = <String>[];

    for (final key in allState.keys) {
      if (key.startsWith('${restorationKey}_')) {
        keysToRemove.add(key);
      }
    }

    for (final key in keysToRemove) {
      _restorationService.updateAppState(key, null);
    }
  }

  /// Create a PageStorageKey for this screen
  PageStorageKey<String> get pageStorageKey =>
      PageStorageKey<String>(restorationKey);

  /// Create a scroll restoration key for this screen
  PageStorageKey<String> get scrollPageStorageKey =>
      PageStorageKey<String>(scrollRestorationKey);

  /// Check if this screen has saved state
  bool get hasSavedState {
    return _restorationService.getScrollPosition(scrollRestorationKey) > 0 ||
        _restorationService.appState.keys.any(
          (key) => key.startsWith('${restorationKey}_'),
        );
  }

  /// Restore scroll position to a ScrollController
  void restoreScrollPosition(ScrollController controller) {
    final savedPosition = currentScrollPosition;
    if (savedPosition > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients) {
          controller.jumpTo(savedPosition);
        }
      });
    }
  }

  /// Save scroll position from a ScrollController
  void saveScrollPositionFromController(ScrollController controller) {
    if (controller.hasClients) {
      saveScrollPosition(controller.offset);
    }
  }

  /// Listen to scroll changes and save position
  void listenToScrollChanges(ScrollController controller) {
    controller.addListener(() {
      if (controller.hasClients) {
        saveScrollPosition(controller.offset);
      }
    });
  }
}

/// Mixin for tab screens to handle tab index restoration
mixin AppTabRestorationMixin<T extends StatefulWidget> on State<T> {
  late final StateRestorationService _restorationService =
      StateRestorationService.instance;

  /// Get current tab index
  int get currentTabIndex => _restorationService.currentTabIndex;

  /// Save current tab index
  void saveTabIndex(int index) {
    _restorationService.updateTabIndex(index);
  }

  /// Restore tab index to a TabController
  void restoreTabIndex(TabController controller) {
    final savedIndex = currentTabIndex;
    if (savedIndex >= 0 && savedIndex < controller.length) {
      // Use multiple post-frame callbacks to ensure the controller is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.index != savedIndex) {
          controller.animateTo(savedIndex);

          // Add another post-frame callback to ensure the animation completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (controller.index != savedIndex) {
              controller.animateTo(savedIndex);
            }
          });
        }
      });
    }
  }

  /// Register for tab index change notifications
  void registerForTabIndexChanges(TabController controller) {
    _restorationService.registerTabIndexCallback(() {
      if (mounted && controller.index != currentTabIndex) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && controller.index != currentTabIndex) {
            controller.animateTo(currentTabIndex);

            // Add another post-frame callback to ensure the animation completes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && controller.index != currentTabIndex) {
                controller.animateTo(currentTabIndex);
              }
            });
          }
        });
      }
    });
  }

  /// Unregister from tab index change notifications
  void unregisterFromTabIndexChanges() {
    _restorationService.unregisterTabIndexCallback();
  }

  /// Listen to tab changes and save index
  void listenToTabChanges(TabController controller) {
    controller.addListener(() {
      if (controller.indexIsChanging) {
        // Don't save tab index during restoration to avoid conflicts
        if (!_restorationService.isRestoring) {
          saveTabIndex(controller.index);
        }
      }
    });
  }
}
