import 'dart:io';
import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String position;
  final String salary;
  final String status;
  final Color statusColor;
  final String notes;
  final File? image;

  Employee({
    required this.name,
    required this.position,
    required this.salary,
    required this.status,
    required this.statusColor,
    required this.notes,
    this.image,
  });
}
