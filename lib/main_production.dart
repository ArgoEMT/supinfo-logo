import 'app.dart' as app;
import 'config/flavor_config.dart';

void main() {
  // set config to PRODUCTION
  app.run(
    FlavorConfig(
      flavor: Flavor.prod,
    ),
  );
}
