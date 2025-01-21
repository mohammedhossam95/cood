import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/enums.dart';
import '../../../injection_container.dart';

final appThemeProvider = StateProvider<bool>(
    (ref) => sharedPreferences.getAppTheme() == Themes.light);
