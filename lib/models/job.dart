class Job {
  final String title, description, ownerId, documentId;
  final String? salary, image, place;

  Job({
    required this.title,
    required this.description,
    required this.ownerId,
    required this.salary,
    required this.documentId,
    this.place,
    this.image,
  });

  Job.fromJsonm(Map<String, dynamic> json, String docId)
      : this(
          documentId: docId,
          ownerId: json['ownerId'],
          title: json['title'],
          description: json['description'],
          place: json['place'],
          salary: json['salary'],
          image: json['image'],
        );

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'title': title,
        'description': description,
        'place': place,
        'salary': salary,
        'image': image,
      };

  Job copyWith({
    String? title,
    String? description,
    String? documentId,
    String? ownerId,
    String? place,
    String? salary,
    String? image,
    String? searchText,
  }) =>
      Job(
        documentId: documentId ?? this.documentId,
        title: title ?? this.title,
        description: description ?? this.description,
        ownerId: ownerId ?? this.ownerId,
        place: place ?? this.place,
        salary: salary ?? this.salary,
      );
}
