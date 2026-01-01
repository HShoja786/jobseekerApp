class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type; // e.g., Full-time
  final String description;
  final DateTime postedAt;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.postedAt,
  });

  factory Job.fromJson(Map<String, dynamic> j) => Job(
    id: j['id'],
    title: j['title'],
    company: j['company'],
    location: j['location'],
    type: j['type'],
    description: j['description'],
    postedAt: DateTime.parse(j['postedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'company': company,
    'location': location,
    'type': type,
    'description': description,
    'postedAt': postedAt.toIso8601String(),
  };
}
