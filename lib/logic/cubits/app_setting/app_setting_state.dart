part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  const AppSettingState({
    required this.themeMode,
  });

  final ThemeMode themeMode;

  Map<String, dynamic> toMap() {
    return {
      "themeMode": themeMode.index,
    };
  }

  factory AppSettingState.fromMap(Map<String, dynamic> map) {
    return AppSettingState(
        themeMode: ThemeMode.values[map["themeMode"] as int],

    );
  }

  @override
  List<Object> get props => [themeMode];

  AppSettingState copyWith({
    ThemeMode? themeMode,


  }) {
    return AppSettingState(
        themeMode: themeMode ?? this.themeMode,

    );
  }
}