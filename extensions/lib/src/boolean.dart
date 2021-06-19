import 'package:simple_i18n_core/simple_i18n_core.dart';

extension BooleanExtensions on bool? {
  String get yesNo {
    return this == true ? 'Yes'.l10n : 'No'.l10n;
  }

  String get yesNoUnknown {
    return this == true
        ? 'Yes'.l10n
        : this == false
            ? 'No'.l10n
            : 'Unknown'.l10n;
  }
}
