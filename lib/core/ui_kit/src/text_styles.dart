import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTextStyles {
  static const TextStyle subtitle = TextStyle(
    color: AppColors.nero,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 22.4 / 16,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle body1 = TextStyle(
    color: AppColors.nero,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 19.6 / 14,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle body2 = TextStyle(
    color: AppColors.nero,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 19.6 / 14,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle caption1 = TextStyle(
    color: AppColors.nero,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16.8 / 12,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle caption2 = TextStyle(
    color: AppColors.nero,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16.8 / 12,
    textBaseline: TextBaseline.alphabetic,
  );
}
