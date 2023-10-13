import 'package:flutter/material.dart';

import 'app.dart' as app;
import 'config/flavor_config.dart';

void main() {
  // set config to QA
  app.run(
    FlavorConfig(
      flavor: Flavor.qa,
      color: const Color(0xFF1A1F93),
    ),
  );
}
