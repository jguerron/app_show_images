// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final String title;
  final String link;
  final String description;
  final DateTime modified;
  final String generator;
  final List<Item> items;

  Welcome({
    required this.title,
    required this.link,
    required this.description,
    required this.modified,
    required this.generator,
    required this.items,
  });

  Welcome copyWith({
    String? title,
    String? link,
    String? description,
    DateTime? modified,
    String? generator,
    List<Item>? items,
  }) =>
      Welcome(
        title: title ?? this.title,
        link: link ?? this.link,
        description: description ?? this.description,
        modified: modified ?? this.modified,
        generator: generator ?? this.generator,
        items: items ?? this.items,
      );

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        title: json["title"],
        link: json["link"],
        description: json["description"],
        modified: DateTime.parse(json["modified"]),
        generator: json["generator"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "description": description,
        "modified": modified.toIso8601String(),
        "generator": generator,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final String? title; // Cambia a nullable
  final String? link;
  final Media? media;
  final DateTime? dateTaken;
  final String? description;
  final DateTime? published;
  final Author? author;
  final AuthorId? authorId;
  final String? tags;

  Item({
    required this.title,
    required this.link,
    required this.media,
    required this.dateTaken,
    required this.description,
    required this.published,
    required this.author,
    required this.authorId,
    required this.tags,
  });

  Item copyWith({
    String? title,
    String? link,
    Media? media,
    DateTime? dateTaken,
    String? description,
    DateTime? published,
    Author? author,
    AuthorId? authorId,
    String? tags,
  }) =>
      Item(
        title: title ?? this.title,
        link: link ?? this.link,
        media: media ?? this.media,
        dateTaken: dateTaken ?? this.dateTaken,
        description: description ?? this.description,
        published: published ?? this.published,
        author: author ?? this.author,
        authorId: authorId ?? this.authorId,
        tags: tags ?? this.tags,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        link: json["link"],
        media: json["media"] != null ? Media.fromJson(json["media"]) : null,
        dateTaken: json["date_taken"] != null
            ? DateTime.parse(json["date_taken"])
            : null,
        description: json["description"],
        published: json["published"] != null
            ? DateTime.parse(json["published"])
            : null,
        author:
            json["author"] != null ? authorValues.map[json["author"]] : null,
        authorId: json["author_id"] != null
            ? authorIdValues.map[json["author_id"]]
            : null,
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "media": media?.toJson(), // Valida si `media` es null
        "date_taken":
            dateTaken?.toIso8601String(), // Valida si `dateTaken` es null
        "description": description,
        "published":
            published?.toIso8601String(), // Valida si `published` es null
        "author": author != null
            ? authorValues.reverse[author]
            : null, // Valida si `author` es null
        "author_id": authorId != null
            ? authorIdValues.reverse[authorId]
            : null, // Valida si `authorId` es null
        "tags": tags,
      };
}

enum Author { NOBODY_FLICKR_COM_THOMASROST, NOBODY_FLICKR_COM_THOMAS_HAWK }

final authorValues = EnumValues({
  "nobody@flickr.com (\"thomasrost\")": Author.NOBODY_FLICKR_COM_THOMASROST,
  "nobody@flickr.com (\"Thomas Hawk\")": Author.NOBODY_FLICKR_COM_THOMAS_HAWK
});

enum AuthorId { THE_16338968_N00, THE_51035555243_N01 }

final authorIdValues = EnumValues({
  "16338968@N00": AuthorId.THE_16338968_N00,
  "51035555243@N01": AuthorId.THE_51035555243_N01
});

class Media {
  final String m;

  Media({
    required this.m,
  });

  Media copyWith({
    String? m,
  }) =>
      Media(
        m: m ?? this.m,
      );

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        m: json["m"],
      );

  Map<String, dynamic> toJson() => {
        "m": m,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
