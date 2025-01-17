// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'argentina_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseModelsHash() => r'b616c0792a9d3b326a9c9eb23506c01b199546cb';

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

/// See also [firebaseModels].
@ProviderFor(firebaseModels)
const firebaseModelsProvider = FirebaseModelsFamily();

/// See also [firebaseModels].
class FirebaseModelsFamily extends Family<AsyncValue<List<CountryModel>>> {
  /// See also [firebaseModels].
  const FirebaseModelsFamily();

  /// See also [firebaseModels].
  FirebaseModelsProvider call(
    String country,
  ) {
    return FirebaseModelsProvider(
      country,
    );
  }

  @override
  FirebaseModelsProvider getProviderOverride(
    covariant FirebaseModelsProvider provider,
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
  String? get name => r'firebaseModelsProvider';
}

/// See also [firebaseModels].
class FirebaseModelsProvider extends FutureProvider<List<CountryModel>> {
  /// See also [firebaseModels].
  FirebaseModelsProvider(
    String country,
  ) : this._internal(
          (ref) => firebaseModels(
            ref as FirebaseModelsRef,
            country,
          ),
          from: firebaseModelsProvider,
          name: r'firebaseModelsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$firebaseModelsHash,
          dependencies: FirebaseModelsFamily._dependencies,
          allTransitiveDependencies:
              FirebaseModelsFamily._allTransitiveDependencies,
          country: country,
        );

  FirebaseModelsProvider._internal(
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
  Override overrideWith(
    FutureOr<List<CountryModel>> Function(FirebaseModelsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FirebaseModelsProvider._internal(
        (ref) => create(ref as FirebaseModelsRef),
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
  FutureProviderElement<List<CountryModel>> createElement() {
    return _FirebaseModelsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FirebaseModelsProvider && other.country == country;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, country.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FirebaseModelsRef on FutureProviderRef<List<CountryModel>> {
  /// The parameter `country` of this provider.
  String get country;
}

class _FirebaseModelsProviderElement
    extends FutureProviderElement<List<CountryModel>> with FirebaseModelsRef {
  _FirebaseModelsProviderElement(super.provider);

  @override
  String get country => (origin as FirebaseModelsProvider).country;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
