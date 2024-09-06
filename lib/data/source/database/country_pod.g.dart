// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countryNotifierHash() => r'1880dc730d96491a01e9e9d9ccda26675a6ecee1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CountryNotifier
    extends BuildlessAutoDisposeStreamNotifier<List<CountryModel>> {
  late final String country;

  Stream<List<CountryModel>> build(
    String country,
  );
}

/// See also [CountryNotifier].
@ProviderFor(CountryNotifier)
const countryNotifierProvider = CountryNotifierFamily();

/// See also [CountryNotifier].
class CountryNotifierFamily extends Family<AsyncValue<List<CountryModel>>> {
  /// See also [CountryNotifier].
  const CountryNotifierFamily();

  /// See also [CountryNotifier].
  CountryNotifierProvider call(
    String country,
  ) {
    return CountryNotifierProvider(
      country,
    );
  }

  @override
  CountryNotifierProvider getProviderOverride(
    covariant CountryNotifierProvider provider,
  ) {
    return call(
      provider.country,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'countryNotifierProvider';
}

/// See also [CountryNotifier].
class CountryNotifierProvider extends AutoDisposeStreamNotifierProviderImpl<
    CountryNotifier, List<CountryModel>> {
  /// See also [CountryNotifier].
  CountryNotifierProvider(
    String country,
  ) : this._internal(
          () => CountryNotifier()..country = country,
          from: countryNotifierProvider,
          name: r'countryNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$countryNotifierHash,
          dependencies: CountryNotifierFamily._dependencies,
          allTransitiveDependencies:
              CountryNotifierFamily._allTransitiveDependencies,
          country: country,
        );

  CountryNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.country,
  }) : super.internal();

  final String country;

  @override
  Stream<List<CountryModel>> runNotifierBuild(
    covariant CountryNotifier notifier,
  ) {
    return notifier.build(
      country,
    );
  }

  @override
  Override overrideWith(CountryNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CountryNotifierProvider._internal(
        () => create()..country = country,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        country: country,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<CountryNotifier, List<CountryModel>>
      createElement() {
    return _CountryNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CountryNotifierProvider && other.country == country;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, country.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CountryNotifierRef
    on AutoDisposeStreamNotifierProviderRef<List<CountryModel>> {
  /// The parameter `country` of this provider.
  String get country;
}

class _CountryNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<CountryNotifier,
        List<CountryModel>> with CountryNotifierRef {
  _CountryNotifierProviderElement(super.provider);

  @override
  String get country => (origin as CountryNotifierProvider).country;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
