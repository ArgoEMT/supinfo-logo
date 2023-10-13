Ce package fournit un ensemble d'icones utilisées par le projet [DematAgri](http://app.dematagri.fr).

## Installation
Ajouter la dépendance dans le fichier pubspec.yaml

```yaml
dependencies:
  okteo_flutter_icons: 
    git:
        url: https://gitinterne.okteo.fr/okteo-libs/flutter/okteo_flutter_icons.git
        ref: master
```

## Utilisation
Les widgets sont disponibles dans le package `okteo_flutter_icons` et sont utilisable comme suit:

```dart
import 'package:okteo_flutter_widgets/okteo_flutter_icons.dart';

class main {
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: OkteoIcon(OkteoIcons.homeFilled)
            )
        );
    }
}
```
Le widget OkteoIcon est un override du widget Icon de Flutter, il fonctionne donc de la même manière. Il est aussi capable d'utiliser les icones de Material Design, en plus de celle fournies par le package. 

Pour plus d'information, voir exemple/lib/