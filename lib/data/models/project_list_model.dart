class ProjectLink {
  final String label;
  final String url;

  const ProjectLink({required this.label, required this.url});

  factory ProjectLink.fromJson(Map<String, dynamic> json) {
    return ProjectLink(label: json['label'], url: json['url']);
  }
}

class Project {
  final String title;
  final String companyName;
  final String? client;
  final String shortDescription;
  final String description;
  final List<String> highlights;
  final List<String> techStack;
  final String? icon;
  final List<String> images;
  final List<ProjectLink> links;

  const Project({
    required this.title,
    required this.companyName,
    this.client,
    required this.shortDescription,
    required this.description,
    this.highlights = const [],
    this.techStack = const [],
    this.icon,
    this.images = const [],
    this.links = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      companyName: json['company_name'],
      client: json['client'],
      shortDescription: json['short_description'],
      description: json['description'],
      highlights: List<String>.from(json['highlights'] ?? const []),
      techStack: List<String>.from(json['tech_stack'] ?? const []),
      icon: json['icon'],
      images: List<String>.from(json['images'] ?? const []),
      links: (json['links'] as List? ?? const [])
          .map((link) => ProjectLink.fromJson(link))
          .toList(),
    );
  }
}
