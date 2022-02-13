const String languageTable = 'LANGUAGE';

class LanguageFields {
  static final List<String> values = [
    /// Add all fields
    id, name, lang, parentId, listOrder, category
  ];

  static const String id = 'ID';
  static const String name = 'NAME';
  static const String lang = 'LANG';
  static const String parentId = 'PARENT_ID';
  static const String listOrder = 'LIST_ORDER';
  static const String category = 'CATEGORY';
}

class Language {

  final int id;
  final String name;
  final String? lang;
  final int? parentId;
  final int? listOrder;
  final int? category;

  const Language({
    required this.id,
    required this.name,
    this.lang,
    this.parentId,
    this.listOrder,
    this.category,
  });

  Language copy({
    int? id,
    String? name,
    String? lang,
    int? parentId,
    int? listOrder,
    int? category,
  }) =>
      Language(
        id: id ?? this.id,
        name: name ?? this.name,
        lang: lang ?? this.lang,
        parentId: parentId ?? this.parentId,
        listOrder: listOrder ?? this.listOrder,
        category: category ?? this.category,
      );

  static Language fromJson(Map<String, Object?> json) => Language(
    id: json[LanguageFields.id] as int,
    name: json[LanguageFields.name] as String,
    lang: json[LanguageFields.lang] as String?,
    parentId: json[LanguageFields.parentId] as int?,
    listOrder: json[LanguageFields.listOrder] as int?,
    category: json[LanguageFields.category] as int?,
  );

  Map<String, Object?> toJson() => {
    LanguageFields.id: id,
    LanguageFields.name: name,
    LanguageFields.lang: lang,
    LanguageFields.parentId: parentId,
    LanguageFields.listOrder: listOrder,
    LanguageFields.category: category,
  };


  /// avoids having to supply custom itemAsString and compareFn in calling widget
  String languageAsString() {
    return '#$id $name';
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool? languageFilterByName(String filter) {
    return name.toString().contains(filter);
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool? languageFilterByCategory(int filter) {
    return category! < filter;
  }

  /// avoids having to supply custom itemAsString and compareFn in calling widget
  bool isEqual(Language? lang) {
    return id == lang?.id;
  }

  @override
  String toString() => name;
}

