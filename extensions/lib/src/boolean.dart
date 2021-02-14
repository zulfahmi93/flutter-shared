extension BooleanExtensions on bool? {
  String get yesNo {
    return this == true ? 'Yes' : 'No';
  }

  String get yesNoUnknown {
    return this == true ? 'Yes' : this == false ? 'No' : 'Unknown';
  }
}
