/// @docImport 'package:flutter/material.dart';
library;

import "dart:math" as math;

import "package:flutter/rendering.dart";

const double maxRadians = math.pi * 2;

const double topLeftCorner = (180 + 45) * math.pi / 180;
const double topCenter = -(math.pi / 2);

/// default constraints for [CircularProgressIndicator] Material 3 y2023 and Material 2
const BoxConstraints circularDefaultConstraints = BoxConstraints(minWidth: 36, minHeight: 36);

/// default constraints for [LinearProgressIndicator] Material 3 y2023, Material 3 and Material 2
const double linearDefaultMinHeight = 4;
