// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'method_channel_shared_preferences.dart';

/// The interface that implementations of shared_preferences must implement.
abstract base class SharedPreferencesStorePlatform {
  /// The shared instance of [SharedPreferencesStorePlatform] to use.
  ///
  /// Defaults to [MethodChannelSharedPreferencesStore].
  static SharedPreferencesStorePlatform instance =
      MethodChannelSharedPreferencesStore();

  /// Removes the value associated with the [key].
  Future<bool> remove(String key);

  /// Stores the [value] associated with the [key].
  ///
  /// The [valueType] must match the type of [value] as follows:
  ///
  /// * Value type "Bool" must be passed if the value is of type `bool`.
  /// * Value type "Double" must be passed if the value is of type `double`.
  /// * Value type "Int" must be passed if the value is of type `int`.
  /// * Value type "String" must be passed if the value is of type `String`.
  /// * Value type "StringList" must be passed if the value is of type `List<String>`.
  Future<bool> setValue(String valueType, String key, Object value);

  /// Removes all keys and values in the store where the key starts with 'flutter.'.
  ///
  /// This default behavior is for backwards compatibility with older versions of this
  /// plugin, which did not support custom prefixes, and instead always used the
  /// prefix 'flutter.'.
  Future<bool> clear();

  /// Removes all keys and values in the store with given prefix.
  Future<bool> clearWithPrefix(String prefix) {
    throw UnimplementedError('clearWithPrefix is not implemented.');
  }

  /// Returns all key/value pairs persisted in this store where the key starts with 'flutter.'.
  ///
  /// This default behavior is for backwards compatibility with older versions of this
  /// plugin, which did not support custom prefixes, and instead always used the
  /// prefix 'flutter.'.
  Future<Map<String, Object>> getAll();

  /// Returns all key/value pairs persisting in this store that have given [prefix].
  Future<Map<String, Object>> getAllWithPrefix(String prefix) {
    throw UnimplementedError('getAllWithPrefix is not implemented.');
  }
}

/// Stores data in memory.
///
/// Data does not persist across application restarts. This is useful in unit-tests.
base class InMemorySharedPreferencesStore
    extends SharedPreferencesStorePlatform {
  /// Instantiates an empty in-memory preferences store.
  InMemorySharedPreferencesStore.empty() : _data = <String, Object>{};

  /// Instantiates an in-memory preferences store containing a copy of [data].
  InMemorySharedPreferencesStore.withData(Map<String, Object> data)
      : _data = Map<String, Object>.from(data);

  final Map<String, Object> _data;
  static const String _defaultPrefix = 'flutter.';

  @override
  Future<bool> clear() async {
    return clearWithPrefix(_defaultPrefix);
  }

  @override
  Future<bool> clearWithPrefix(String prefix) async {
    _data.removeWhere((String key, _) => key.startsWith(prefix));
    return true;
  }

  @override
  Future<Map<String, Object>> getAll() async {
    return getAllWithPrefix(_defaultPrefix);
  }

  @override
  Future<Map<String, Object>> getAllWithPrefix(String prefix) async {
    final Map<String, Object> preferences = Map<String, Object>.from(_data);
    preferences.removeWhere((String key, _) => !key.startsWith(prefix));
    return preferences;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    _data[key] = value;
    return true;
  }
}
