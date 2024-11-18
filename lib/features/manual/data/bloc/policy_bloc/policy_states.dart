import 'package:equatable/equatable.dart';
import '../../models/policy_model.dart';

abstract class PolicyStates extends Equatable {}

final class PolicyInitialState extends PolicyStates {
  @override
  List<Object?> get props => [];
}

final class PolicyProcessingState extends PolicyStates {
  @override
  List<Object?> get props => [];
}

final class PolicyLoadedState extends PolicyStates {
  final List<PolicyModel> policyList;
  PolicyLoadedState(this.policyList);

  @override
  List<Object?> get props => [policyList];
}
