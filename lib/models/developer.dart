import 'package:company_developer/models/emploees.dart';
import 'package:company_developer/models/products.dart';

class Developer {
  final String company;
  final String location;
  final List<Employees> employees;
  final List<Product> products;

  Developer({
    required this.company,
    required this.location,
    required this.employees,
    required this.products,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      company: json['company'],
      location: json['location'],
      employees: List<Employees>.from(
        json['employees'].map((employee) => Employees.fromJson(employee)),
      ),
      products: List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      ),
    );
  }
}
