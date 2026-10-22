import 'custom_service.dart';
import 'experience_model.dart';

class ProfileStat {
  final String value;
  final String label;

  const ProfileStat({required this.value, required this.label});

  factory ProfileStat.fromJson(Map<String, dynamic> json) {
    return ProfileStat(value: json['value'], label: json['label']);
  }
}

class SkillGroup {
  final String group;
  final List<String> items;

  const SkillGroup({required this.group, required this.items});

  factory SkillGroup.fromJson(Map<String, dynamic> json) {
    return SkillGroup(
      group: json['group'],
      items: List<String>.from(json['items']),
    );
  }
}

class Education {
  final String degree;
  final String institute;
  final String duration;

  const Education({
    required this.degree,
    required this.institute,
    required this.duration,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      institute: json['institute'],
      duration: json['duration'],
    );
  }
}

class Profile {
  final String name;
  final String title;
  final String? headline;
  final List<String> roles;
  final String? availability;
  final List<String> heroBadges;
  final String? photo;
  final String location;
  final String email;
  final String resume;

  /// Initials for the avatar shown when no photo is set.
  String get initials => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
  final String intro;
  final List<String> about;
  final List<ProfileStat> stats;
  final List<WorkingExperience> experience;
  final Education? education;
  final List<CustomService> services;
  final List<SkillGroup> skills;

  const Profile({
    required this.name,
    required this.title,
    this.headline,
    this.roles = const [],
    this.availability,
    this.heroBadges = const [],
    this.photo,
    required this.location,
    required this.email,
    required this.resume,
    required this.intro,
    required this.about,
    required this.stats,
    required this.experience,
    this.education,
    required this.services,
    required this.skills,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      title: json['title'],
      headline: json['headline'],
      roles: List<String>.from(json['roles'] ?? const []),
      availability: json['availability'],
      heroBadges: List<String>.from(json['hero_badges'] ?? const []),
      photo: json['photo'],
      location: json['location'],
      email: json['email'],
      resume: json['resume'],
      intro: json['intro'],
      about: List<String>.from(json['about']),
      stats: (json['stats'] as List? ?? const [])
          .map((stat) => ProfileStat.fromJson(stat))
          .toList(),
      experience: (json['experience'] as List)
          .map((exp) => WorkingExperience.fromJson(exp))
          .toList(),
      education: json['education'] == null
          ? null
          : Education.fromJson(json['education']),
      services: (json['services'] as List)
          .map((service) => CustomService.fromJson(service))
          .toList(),
      skills: (json['skills'] as List)
          .map((group) => SkillGroup.fromJson(group))
          .toList(),
    );
  }
}
