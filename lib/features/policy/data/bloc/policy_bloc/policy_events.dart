import '../../../../manual/data/models/policy_page.dart';

abstract class PolicyEvents {}

final class LoadPolicyEvent extends PolicyEvents {}

final class SavePolicyEvent extends PolicyEvents {
  final PolicyPage policyModel;
  SavePolicyEvent(this.policyModel);
}
