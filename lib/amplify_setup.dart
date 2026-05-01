import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_together/amplifyconfiguration.dart';

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();

    await Amplify.addPlugins([auth, api]);

    await Amplify.configure(amplifyconfig);
  } catch (e) {
    debugPrint('Amplify already configured or error: $e');
  }
}