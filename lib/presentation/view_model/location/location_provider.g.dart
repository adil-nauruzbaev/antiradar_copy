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
String _$locationHash() => r'57c9e443e5f01c29c59db6194dbbe1af6d849b9a';

/// See also [location].
@ProviderFor(location)
final locationProvider = AutoDisposeStreamProvider<GeoPosition>.internal(
  location,
  name: r'locationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$locationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationRef = AutoDisposeStreamProviderRef<GeoPosition>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
