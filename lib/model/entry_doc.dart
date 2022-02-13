const String entryDocView = 'entry_doc';

class EntryDocFields {
  static final List<String> values = [
    /// Add all fields
    entryId, docId, doc, docType
  ];

  static const String entryId = 'entry_id';
  static const String docId = 'doc_id';
  static const String doc = 'doc';
  static const String docType = 'docType';
}

class EntryDoc {

  final int entryId;
  final int docId;
  final String doc;
  final String docType;

  const EntryDoc({
    required this.entryId,
    required this.docId,
    required this.doc,
    required this.docType,
  });

  EntryDoc copy({
    int? entryId,
    int? docId,
    String? doc,
    String? docType,
  }) {
    return EntryDoc(
      entryId: entryId ?? this.entryId,
      docId: docId ?? this.docId,
      doc: doc ?? this.doc,
      docType: docType ?? this.docType,
    );
  }

  static EntryDoc fromJson(Map<String, Object?> json) => EntryDoc(
    entryId: json[EntryDocFields.entryId] as int,
    docId: json[EntryDocFields.docId] as int,
    doc: json[EntryDocFields.doc] as String,
    docType: json[EntryDocFields.docType] as String,
  );

  Map<String, Object?> toJson() => {
    EntryDocFields.entryId: entryId,
    EntryDocFields.docId: docId,
    EntryDocFields.doc: doc,
    EntryDocFields.docType: docType,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryDoc &&
          runtimeType == other.runtimeType &&
          entryId == other.entryId &&
          docId == other.docId &&
          doc == other.doc &&
          docType == other.docType);

  @override
  int get hashCode =>
      entryId.hashCode ^
      docId.hashCode ^
      doc.hashCode ^
      docType.hashCode;

  @override
  String toString() {
    return 'EntryDoc{' +
        ' entryId: $entryId,' +
        ' docId: $docId,' +
        ' doc: $doc,' +
        ' docType: $docType,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'entryId': this.entryId,
      'docId': this.docId,
      'doc': this.doc,
      'docType': this.docType,
    };
  }

  factory EntryDoc.fromMap(Map<String, dynamic> map) {
    return EntryDoc(
      entryId: map['entryId'] as int,
      docId: map['docId'] as int,
      doc: map['doc'] as String,
      docType: map['docType'] as String,
    );
  }
}