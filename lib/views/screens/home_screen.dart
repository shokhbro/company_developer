import 'package:company_developer/controller/developer_controller.dart';
import 'package:company_developer/models/developer.dart';
import 'package:company_developer/models/emploees.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final DeveloperController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  void _showEmployeeDialog({Employees? employee, int? index}) {
    if (employee != null) {
      _nameController.text = employee.name;
      _ageController.text = employee.age.toString();
      _positionController.text = employee.position;
      _skillsController.text = employee.skills.join(', ');
    } else {
      _nameController.clear();
      _ageController.clear();
      _positionController.clear();
      _skillsController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(employee == null ? 'Add Employee' : 'Edit Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              TextField(
                controller: _skillsController,
                decoration: const InputDecoration(
                    labelText: 'Skills (comma separated)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = _nameController.text;
                final age = int.parse(_ageController.text);
                final position = _positionController.text;
                final skills = _skillsController.text.split(', ').toList();

                final newEmployee = Employees(
                  name: name,
                  age: age,
                  position: position,
                  skills: skills,
                );

                if (index == null) {
                  widget.controller.addEmployee(newEmployee);
                } else {
                  widget.controller.editEmployee(index, newEmployee);
                }

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Company Developer',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showEmployeeDialog();
              },
              child: const Text('Add Employee'),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Developer>(
              valueListenable: widget.controller.developerNotifier,
              builder: (context, developer, _) {
                return ListView.builder(
                  itemCount: developer.employees.length,
                  itemBuilder: (context, index) {
                    final employee = developer.employees[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(employee.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employee.position),
                              Text('Age: ${employee.age}'),
                              Text('Skills: ${employee.skills.join(', ')}'),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: -10,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showEmployeeDialog(
                                      employee: employee, index: index);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  widget.controller.deleteEmployee(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Developer>(
              valueListenable: widget.controller.developerNotifier,
              builder: (context, developer, _) {
                return ListView.builder(
                  itemCount: developer.products.length,
                  itemBuilder: (context, index) {
                    final product = developer.products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: \$${product.price}'),
                              Text(
                                  'In Stock: ${product.inStock ? "Yes" : "No"}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
