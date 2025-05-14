import 'dart:async';

import 'package:rxdart/utils.dart';

mixin DisposableMixin {
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  final CompositeSubscription _subscriptions = CompositeSubscription();

  void disposeAll() {
    _subscriptions.clear();
    _isDisposed = true;
  }

  void addSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }
}

extension StreamExtension on StreamSubscription<dynamic> {
  void dispose(DisposableMixin cubit) {
    cubit.addSubscription(this);
  }
}
