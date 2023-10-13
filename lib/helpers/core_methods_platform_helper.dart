import 'dart:io' as io;

import 'package:flutter/foundation.dart';

/// Retourne si le téléphone est sur iOS.
bool get isIOS => !kIsWeb && io.Platform.isIOS;
