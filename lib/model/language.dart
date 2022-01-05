final String tableLanguages = 'LANGUAGE';

class LanguageFields {
  static final List<String> values = [
    /// Add all fields
    id, name, mnemonic, parentId
  ];

  static const String id = 'ID';
  static const String name = 'NAME';
  static const String mnemonic = 'MNEMONIC';
  static const String parentId = 'PARENT_ID';
}

class Language {

  final int id;
  final String name;
  final String? mnemonic;
  final int? parentId;

  const Language({
    required this.id,
    required this.name,
    this.mnemonic,
    this.parentId,
  });

  Language copy({
    int? id,
    String? name,
    String? mnemonic,
    int? parentId,
  }) =>
      Language(
        id: id ?? this.id,
        name: name ?? this.name,
        mnemonic: mnemonic ?? this.mnemonic,
        parentId: parentId ?? this.parentId,
      );

  static Language fromJson(Map<String, Object?> json) => Language(
    id: json[LanguageFields.id] as int,
    name: json[LanguageFields.name] as String,
    mnemonic: json[LanguageFields.mnemonic] as String?,
    parentId: json[LanguageFields.parentId] as int?,
  );

  Map<String, Object?> toJson() => {
    LanguageFields.id: id,
    LanguageFields.name: name,
    LanguageFields.mnemonic: mnemonic,
    LanguageFields.parentId: parentId,
  };
}

