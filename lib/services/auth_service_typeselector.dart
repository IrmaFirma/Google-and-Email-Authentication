import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/components/segmented_control.dart';
import 'package:testing_app/components/strings.dart';


import 'auth_service_adapter.dart';
import 'auth_service.dart';

class AuthServiceTypeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthServiceAdapter authServiceAdapter =
        Provider.of<AuthService>(context, listen: false);
    return ValueListenableBuilder<AuthServiceType>(
      valueListenable: authServiceAdapter.authServiceTypeNotifier,
      builder: (_, AuthServiceType type, __) {
        return SegmentedControl<AuthServiceType>(
          header: Text(
            Strings.authenticationType,
            style: TextStyle(fontSize: 16.0),
          ),
          value: type,
          onValueChanged: (AuthServiceType type) =>
              authServiceAdapter.authServiceTypeNotifier.value = type,
          children: const <AuthServiceType, Widget>{
            AuthServiceType.firebase: Text(Strings.firebase),
            AuthServiceType.mock: Text(Strings.mock),
          },
        );
      },
    );
  }
}
