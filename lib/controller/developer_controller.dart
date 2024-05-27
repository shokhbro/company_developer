import 'package:company_developer/models/developer.dart';
import 'package:company_developer/models/emploees.dart';
import 'package:flutter/material.dart';

class DeveloperController extends ChangeNotifier {
  final ValueNotifier<Developer>  _developerNotifier;

  DeveloperController(Developer developer)
      : _developerNotifier = ValueNotifier<Developer>(developer);

  ValueNotifier<Developer> get developerNotifier => _developerNotifier;

  Developer get developer => _developerNotifier.value;

  void addEmployee(Employees employee) {
    _developerNotifier.value.employees.add(employee);
    _developerNotifier.notifyListeners();
  }

  void editEmployee(int index, Employees employee) {
    _developerNotifier.value.employees[index] = employee;
    _developerNotifier.notifyListeners();
  }

  void deleteEmployee(int index) {
    _developerNotifier.value.employees.removeAt(index);
    _developerNotifier.notifyListeners();
  }
}
