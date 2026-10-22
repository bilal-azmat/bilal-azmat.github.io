import 'dart:convert';

import 'package:flutter/services.dart';

import 'models/profile.dart';
import 'models/project_list_model.dart';

/// All site content lives in assets/json so it can be edited without
/// touching Dart code. Loaded once in main() before the app starts.
abstract class PortfolioData {
  static late Profile profile;
  static late List<Project> projects;

  static Future<void> load() async {
    final profileJson = await rootBundle.loadString('assets/json/profile.json');
    final projectsJson =
        await rootBundle.loadString('assets/json/projects.json');

    profile = Profile.fromJson(json.decode(profileJson));
    projects = (json.decode(projectsJson) as List)
        .map((project) => Project.fromJson(project))
        .toList();
  }

  /// Project categories in the order they first appear in projects.json.
  static List<String> get categories =>
      projects.map((project) => project.companyName).toSet().toList();
}
