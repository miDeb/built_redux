library collection_models;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'collection_models.g.dart';

// CollectionActions contains actions that mutate the different
// built collections contained inside Collection
abstract class CollectionActions extends ReduxActions {
  CollectionActions._();
  factory CollectionActions() => _$CollectionActions();

  VoidActionDispatcher get builtListAction;
  VoidActionDispatcher get builtListMultimapAction;
  VoidActionDispatcher get builtMapAction;
  VoidActionDispatcher get builtSetAction;
  VoidActionDispatcher get builtSetMultimapAction;
}

// Collection contains one of each built_collection type
abstract class Collection implements Built<Collection, CollectionBuilder> {
  BuiltList<int> get builtList;
  BuiltListMultimap<int, int> get builtListMultimap;
  BuiltMap<int, int> get builtMap;
  BuiltSet<int> get builtSet;
  BuiltSetMultimap<int, int> get builtSetMultimap;

  Collection._();
  factory Collection() => _$Collection();
}

// getCollectionReducer returns a Reducer that rebuilds Collection.
// It combines the child and grandchild ReducerBuilders.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Collection object.
// Reducers added to the ReducerBuilder must have the signature:
// (Collection, Action<T>, CollectionBuilder)
Reducer<Collection, CollectionBuilder, dynamic> getCollectionReducer() =>
    (ReducerBuilder<Collection, CollectionBuilder>()
          ..combineList(getListReducer())
          ..combineListMultimap(getListMultimapReducer())
          ..combineMap(getMapReducer())
          ..combineSet(getSetReducer())
          ..combineSetMultimap(getSetMultimapReducer()))
        .build();

// getListReducer returns a ListReducerBuilder that rebuilds the list
// when builtListAction is dispatched. This ListReducerBuilder
// could be modified to handle more actions that rebuild builtList.
// Reducers added to the ListReducerBuilder must have the signature:
// (BuiltList<int>, Action<T>, ListBuilder<int>)
ListReducerBuilder<Collection, CollectionBuilder, int> getListReducer() =>
    ListReducerBuilder<Collection, CollectionBuilder, int>(
        (s) => s.builtList, (b) => b.builtList)
      ..add<void>(
          CollectionActionsNames.builtListAction, (s, a, b) => b.add(0));

// getListMultimapReducer returns a ListMultimapReducerBuilder that rebuilds the list multimap
// when builtListMultimapAction is dispatched. This ListMultimapReducerBuilder
// could be modified to handle more actions that rebuild builtListMultimap.
// Reducers added to the ListMultimapReducerBuilder must have the signature:
// (BuiltListMultimap<int, int>, Action<T>, ListMultimapBuilder<int, int>)
ListMultimapReducerBuilder<Collection, CollectionBuilder, int, int>
    getListMultimapReducer() =>
        ListMultimapReducerBuilder<Collection, CollectionBuilder, int, int>(
            (s) => s.builtListMultimap, (b) => b.builtListMultimap)
          ..add<void>(CollectionActionsNames.builtListMultimapAction,
              (s, a, b) => b.add(0, 0));

// getMapReducer returns a MapReducerBuilder that rebuilds the map
// when builtMapAction is dispatched. This MapReducerBuilder
// could be modified to handle more actions that rebuild builtMap.
// Reducers added to the MapReducerBuilder must have the signature:
// (BuiltMap<int, int>, Action<T>, MapBuilder<int, int>)
MapReducerBuilder<Collection, CollectionBuilder, int, int> getMapReducer() =>
    MapReducerBuilder<Collection, CollectionBuilder, int, int>(
        (s) => s.builtMap, (b) => b.builtMap)
      ..add<void>(CollectionActionsNames.builtMapAction, (s, a, b) => b[0] = 0);

// getSetReducer returns a SetReducerBuilder that rebuilds the set
// when builtSetAction is dispatched. This SetReducerBuilder
// could be modified to handle more actions that rebuild builtSet.
// Reducers added to the SetReducerBuilder must have the signature:
// (Set<int>, Action<T>, SetBuilder<int>)
SetReducerBuilder<Collection, CollectionBuilder, int> getSetReducer() =>
    SetReducerBuilder<Collection, CollectionBuilder, int>(
        (s) => s.builtSet, (b) => b.builtSet)
      ..add<void>(CollectionActionsNames.builtSetAction, (s, a, b) => b.add(0));

// getSetMultimapReducer returns a SetMultimapReducerBuilder that rebuilds the set multimap
// when builtSetMultimapAction is dispatched. This SetMultimapReducerBuilder
// could be modified to handle more actions that rebuild builtSetMultimap.
// Reducers added to the SetMultimapReducerBuilder must have the signature:
// (BuiltSetMultimap<int, int>, Action<T>, SetMultimapBuilder<int, int>)
SetMultimapReducerBuilder<Collection, CollectionBuilder, int, int>
    getSetMultimapReducer() =>
        SetMultimapReducerBuilder<Collection, CollectionBuilder, int, int>(
            (s) => s.builtSetMultimap, (b) => b.builtSetMultimap)
          ..add<void>(CollectionActionsNames.builtSetMultimapAction,
              (s, a, b) => b.add(0, 0));
