part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class LoadingSettings extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final String theme;
  final String dateFormat;

  SettingsLoaded(this.theme, this.dateFormat);
}
