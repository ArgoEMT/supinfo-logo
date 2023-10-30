import 'package:flutter/material.dart';

import 'app.dart' as app;
import 'config/flavor_config.dart';

void main() {
  // set config to DEV
  app.run(
    FlavorConfig(
      flavor: Flavor.dev,
      color: const Color(0xFF931A1A),
    ),
  );
}
