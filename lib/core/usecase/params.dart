import 'package:equatable/equatable.dart';

abstract class Params extends Equatable {
  const Params();
}

class NoParams extends Params {
  const NoParams();

  @override
  List<Object?> get props => [];
}
