const String nothrimView = 'nothrim';

class NothrimFields {
  static final List<String> values = [
    /// Add all fields
    id
  ];

  static const String id = 'id';
}

class Nothrim {

  final int id;

  const Nothrim({
    required this.id,
  });

  Nothrim copy({
    int? id,
  }) {
    return Nothrim(
      id: id ?? this.id,
    );
  }


  static Nothrim fromJson(Map<String, Object?> json) => Nothrim(
    id: json[NothrimFields.id] as int,
  );

  Map<String, Object?> toJson() => {
    NothrimFields.id: id,
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Nothrim &&
              runtimeType == other.runtimeType &&
              id == other.id);

  @override
  int get hashCode =>
      id.hashCode;

  @override
  String toString() {
    return 'Nothrim{' +
        ' id: $id,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }

  factory Nothrim.fromMap(Map<String, dynamic> map) {
    return Nothrim(
      id: map['id'] as int,
    );
  }
}