import 'package:json_annotation/json_annotation.dart';
part 'categoria.g.dart';

@JsonSerializable()
class Categoria {
  final String nome;

  Categoria({required this.nome});

  factory Categoria.fromJson(Map<String, dynamic> json) =>
      _$CategoriaFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriaToJson(this);
}
