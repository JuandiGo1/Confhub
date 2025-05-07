import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:confhub/data/sources/event_local_data_source.dart';

void main() {
  late EventLocalDataSource localDataSource;

  setUp(() async {
    await setUpTestHive();
    localDataSource = EventLocalDataSource();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  test('Debería guardar y recuperar eventos suscritos correctamente', () async {
    final subscribedEventIds = [1, 2, 3];

    await localDataSource.saveSubscribedEvents(subscribedEventIds);
    final result = await localDataSource.getSubscribedEventIds();

    expect(result, subscribedEventIds);
  });
}