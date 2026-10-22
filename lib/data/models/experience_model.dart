class WorkingExperience {
  final String designation;
  final String companyName;
  final String? client;
  final String duration;
  final String? location;
  final String? logo;
  final List<String> highlights;

  const WorkingExperience({
    required this.designation,
    required this.companyName,
    this.client,
    required this.duration,
    this.location,
    this.logo,
    this.highlights = const [],
  });

  factory WorkingExperience.fromJson(Map<String, dynamic> json) {
    return WorkingExperience(
      designation: json['designation'],
      companyName: json['company_name'],
      client: json['client'],
      duration: json['duration'],
      location: json['location'],
      logo: json['logo'],
      highlights: List<String>.from(json['highlights'] ?? const []),
    );
  }
}
