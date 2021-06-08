import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class AppEffects {
  static const BoxShadow SHADOW_FOR_WHITE = BoxShadow(
    color: AppColors.GRAY_TRANSPARENT,
    blurRadius: 10,
    offset: Offset(0, 2),
  );

  static const BoxShadow SHADOW = BoxShadow(
    color: AppColors.GRAY_TRANSPARENT20,
    blurRadius: 10,
    offset: Offset(0, 2),
  );
}
