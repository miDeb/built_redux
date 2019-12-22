import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('reducer', () {
    Store<Counter, CounterBuilder, CounterActions> store;

    setUp(() {
      var actions = new CounterActions();
      var defaultValue = new Counter();

      store = new Store<Counter, CounterBuilder, CounterActions>(
          reducer, defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('multiple reducer for the same action', () {
      expect(store.state.count, 1);
      store.actions.doubleIncrement(2);
      expect(store.state.count, 5);
    });
  });
}
