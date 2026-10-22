class CustomService {
  final String service;
  final String logo;
  final String description;

  const CustomService({
    required this.service,
    required this.logo,
    required this.description,
  });

  factory CustomService.fromJson(Map<String, dynamic> json) {
    return CustomService(
      service: json['service'],
      logo: json['logo'],
      description: json['description'],
    );
  }
}
