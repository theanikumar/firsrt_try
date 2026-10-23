class Devotee {
  const Devotee({
    required this.id,
    required this.displayName,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.language,
    required this.status,
    required this.onboardingCompleted,
    required this.initials,
  });

  final int id;
  final String displayName;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String language;
  final String status;
  final bool onboardingCompleted;
  final String initials;

  bool get isBlocked => status == 'blocked';

  factory Devotee.fromJson(Map<String, dynamic> json) {
    final displayName = (json['display_name'] ?? '').toString();
    return Devotee(
      id: _asInt(json['id']),
      displayName: displayName,
      name: (json['name'] ?? (displayName.isEmpty ? 'Devotee' : displayName))
          .toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      avatarUrl: (json['avatar_url'] ?? '').toString(),
      language: (json['language'] ?? 'en').toString(),
      status: (json['status'] ?? 'active').toString(),
      onboardingCompleted: json['onboarding_completed'] == true,
      initials: (json['initials'] ?? 'SV').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'display_name': displayName,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar_url': avatarUrl,
        'language': language,
        'status': status,
        'onboarding_completed': onboardingCompleted,
        'initials': initials,
      };
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
