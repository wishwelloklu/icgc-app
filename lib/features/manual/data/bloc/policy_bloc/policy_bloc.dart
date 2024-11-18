import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/policy_model.dart';
import 'policy_states.dart';

import 'policy_events.dart';

class PolicyBloc extends Bloc<PolicyEvents, PolicyStates> {
  PolicyBloc() : super(PolicyInitialState()) {
    on<LoadPolicyEvent>(
      (event, emit) async {
        emit(PolicyProcessingState());
        final policyList = await loadJsonData();
        emit(PolicyLoadedState(policyList));
      },
    );
  }
  Future<List<PolicyModel>> loadJsonData() async {
    // Load the JSON string from the assets
    final String jsonString =
        await rootBundle.loadString('assets/json/policy_doc.json');

    List<dynamic> jsonData = json.decode(jsonString);
    // Decode JSON string into a Dart map or list
    final policyList =
        jsonData.map((item) => PolicyModel.fromMap(item)).toList();

    return policyList;
    // Use the data (this can be cast or used directly depending on your JSON structure)
  }
}
