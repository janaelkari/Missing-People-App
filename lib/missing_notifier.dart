import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_appretry/missing.dart';
class Notifier with ChangeNotifier{
  List<missing> _missingList = [];
  missing _currentmissing;
  UnmodifiableListView <missing> get missingList => UnmodifiableListView(_missingList);
  missing get currentFood => _currentmissing;

  set missingList(List<missing> missingList) {
    _missingList = missingList;
    notifyListeners();
  }

  set currentmissing(missing missingg) {
    _currentmissing = missingg;
    notifyListeners();
  }
}