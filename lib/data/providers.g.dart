// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';

@ProviderFor(contentSource)
final contentSourceProvider = ContentSourceProvider._();

final class ContentSourceProvider
    extends $FunctionalProvider<ContentSource, ContentSource, ContentSource>
    with $Provider<ContentSource> {
  ContentSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentSourceHash();

  @$internal
  @override
  $ProviderElement<ContentSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ContentSource create(Ref ref) {
    return contentSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentSource>(value),
    );
  }
}

String _$contentSourceHash() => r'0ed998e5a77c08b2aa7cff9e22db97a0e4f26abf';

/// Chạy import nội dung một lần khi mở app (nhanh nếu không có gì thay đổi).

@ProviderFor(contentBootstrap)
final contentBootstrapProvider = ContentBootstrapProvider._();

/// Chạy import nội dung một lần khi mở app (nhanh nếu không có gì thay đổi).

final class ContentBootstrapProvider
    extends
        $FunctionalProvider<
          AsyncValue<ImportReport>,
          ImportReport,
          FutureOr<ImportReport>
        >
    with $FutureModifier<ImportReport>, $FutureProvider<ImportReport> {
  /// Chạy import nội dung một lần khi mở app (nhanh nếu không có gì thay đổi).
  ContentBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentBootstrapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentBootstrapHash();

  @$internal
  @override
  $FutureProviderElement<ImportReport> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ImportReport> create(Ref ref) {
    return contentBootstrap(ref);
  }
}

String _$contentBootstrapHash() => r'ef8d27b82761b9625ac8cee0ca3cf4c5863fb19f';

@ProviderFor(wordRepository)
final wordRepositoryProvider = WordRepositoryProvider._();

final class WordRepositoryProvider
    extends $FunctionalProvider<WordRepository, WordRepository, WordRepository>
    with $Provider<WordRepository> {
  WordRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wordRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wordRepositoryHash();

  @$internal
  @override
  $ProviderElement<WordRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WordRepository create(Ref ref) {
    return wordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WordRepository>(value),
    );
  }
}

String _$wordRepositoryHash() => r'82274b161ea64308b0b1e88e6563b6ea84681015';

@ProviderFor(statsRepository)
final statsRepositoryProvider = StatsRepositoryProvider._();

final class StatsRepositoryProvider
    extends
        $FunctionalProvider<StatsRepository, StatsRepository, StatsRepository>
    with $Provider<StatsRepository> {
  StatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatsRepository create(Ref ref) {
    return statsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsRepository>(value),
    );
  }
}

String _$statsRepositoryHash() => r'b7fdbe48b6cee36b0cad75f63eda44a13bdab6f8';

@ProviderFor(lessonRepository)
final lessonRepositoryProvider = LessonRepositoryProvider._();

final class LessonRepositoryProvider
    extends
        $FunctionalProvider<
          LessonRepository,
          LessonRepository,
          LessonRepository
        >
    with $Provider<LessonRepository> {
  LessonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lessonRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lessonRepositoryHash();

  @$internal
  @override
  $ProviderElement<LessonRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LessonRepository create(Ref ref) {
    return lessonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LessonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LessonRepository>(value),
    );
  }
}

String _$lessonRepositoryHash() => r'3042ebebfff2bfd4eb3ad5e43108b2bd83a090e4';

@ProviderFor(strokeRepository)
final strokeRepositoryProvider = StrokeRepositoryProvider._();

final class StrokeRepositoryProvider
    extends
        $FunctionalProvider<
          StrokeRepository,
          StrokeRepository,
          StrokeRepository
        >
    with $Provider<StrokeRepository> {
  StrokeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'strokeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$strokeRepositoryHash();

  @$internal
  @override
  $ProviderElement<StrokeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StrokeRepository create(Ref ref) {
    return strokeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StrokeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StrokeRepository>(value),
    );
  }
}

String _$strokeRepositoryHash() => r'ba81171146c428051fa394ddce982d07a113f2f1';

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'2de17899c89cd144d3e134172002d79d8b2f2dfd';

@ProviderFor(srsRepository)
final srsRepositoryProvider = SrsRepositoryProvider._();

final class SrsRepositoryProvider
    extends $FunctionalProvider<SrsRepository, SrsRepository, SrsRepository>
    with $Provider<SrsRepository> {
  SrsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'srsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$srsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SrsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SrsRepository create(Ref ref) {
    return srsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SrsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SrsRepository>(value),
    );
  }
}

String _$srsRepositoryHash() => r'e4a78b682e3de1f3702752e64e9e207fc429eb46';

@ProviderFor(pronunciationRepository)
final pronunciationRepositoryProvider = PronunciationRepositoryProvider._();

final class PronunciationRepositoryProvider
    extends
        $FunctionalProvider<
          PronunciationRepository,
          PronunciationRepository,
          PronunciationRepository
        >
    with $Provider<PronunciationRepository> {
  PronunciationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pronunciationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pronunciationRepositoryHash();

  @$internal
  @override
  $ProviderElement<PronunciationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PronunciationRepository create(Ref ref) {
    return pronunciationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PronunciationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PronunciationRepository>(value),
    );
  }
}

String _$pronunciationRepositoryHash() =>
    r'cb45be7f79fae9ec4583584c6c8c8017861837ce';
