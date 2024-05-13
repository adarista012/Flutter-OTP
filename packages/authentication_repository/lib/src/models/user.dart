import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String id;
  final String? name;

  const User({
    this.email,
    required this.id,
    this.name,
  });

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name];
}
