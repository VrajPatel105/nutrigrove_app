class PreferenceModel {
  final String label;
  final String value;
  final bool isSelected;
  final String? description;

  PreferenceModel({
    required this.label,
    required this.value,
    this.isSelected = false,
    this.description,
  });

  PreferenceModel copyWith({
    String? label,
    String? value,
    bool? isSelected,
    String? description,
  }) {
    return PreferenceModel(
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      description: description ?? this.description,
    );
  }
}
