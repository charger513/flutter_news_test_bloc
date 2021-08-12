import 'package:equatable/equatable.dart';

class Source extends Equatable {
  const Source({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}
