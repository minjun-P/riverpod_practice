// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentListHash() => r'20fc4c50d41c19db71cde1aabc5ba8b486fa52b0';

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

abstract class _$CommentList extends BuildlessAsyncNotifier<List<Comment>> {
  late final String todoId;

  FutureOr<List<Comment>> build(
    String todoId,
  );
}

/// See also [CommentList].
@ProviderFor(CommentList)
const commentListProvider = CommentListFamily();

/// See also [CommentList].
class CommentListFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentList].
  const CommentListFamily();

  /// See also [CommentList].
  CommentListProvider call(
    String todoId,
  ) {
    return CommentListProvider(
      todoId,
    );
  }

  @override
  CommentListProvider getProviderOverride(
    covariant CommentListProvider provider,
  ) {
    return call(
      provider.todoId,
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
  String? get name => r'commentListProvider';
}

/// See also [CommentList].
class CommentListProvider
    extends AsyncNotifierProviderImpl<CommentList, List<Comment>> {
  /// See also [CommentList].
  CommentListProvider(
    String todoId,
  ) : this._internal(
          () => CommentList()..todoId = todoId,
          from: commentListProvider,
          name: r'commentListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentListHash,
          dependencies: CommentListFamily._dependencies,
          allTransitiveDependencies:
              CommentListFamily._allTransitiveDependencies,
          todoId: todoId,
        );

  CommentListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todoId,
  }) : super.internal();

  final String todoId;

  @override
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentList notifier,
  ) {
    return notifier.build(
      todoId,
    );
  }

  @override
  Override overrideWith(CommentList Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentListProvider._internal(
        () => create()..todoId = todoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todoId: todoId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CommentList, List<Comment>> createElement() {
    return _CommentListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentListProvider && other.todoId == todoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentListRef on AsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `todoId` of this provider.
  String get todoId;
}

class _CommentListProviderElement
    extends AsyncNotifierProviderElement<CommentList, List<Comment>>
    with CommentListRef {
  _CommentListProviderElement(super.provider);

  @override
  String get todoId => (origin as CommentListProvider).todoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
