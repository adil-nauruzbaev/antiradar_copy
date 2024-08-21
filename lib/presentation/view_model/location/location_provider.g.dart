// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationPermissionHash() =>
    r'9fdb8d50462357a2dede6e62f3c4a15ac5142a8b';

/// See also [locationPermission].
@ProviderFor(locationPermission)
final locationPermissionProvider =
    AutoDisposeFutureProvider<LocationPermission>.internal(
  locationPermission,
  name: r'locationPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationPermissionRef
    = AutoDisposeFutureProviderRef<LocationPermission>;
String _$locationHash() => r'f881ad6b037eb873cbd84817b6cf66ced8d02df5';

/// See also [location].
@ProviderFor(location)
final locationProvider = AutoDisposeFutureProvider<Position>.internal(
  location,
  name: r'locationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$locationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationRef = AutoDisposeFutureProviderRef<Position>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
