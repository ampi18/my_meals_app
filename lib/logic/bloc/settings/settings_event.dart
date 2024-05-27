part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class RequestToLoadSettings extends SettingsEvent {}

final class RequestToUpdateSettings extends SettingsEvent {
  final String theme;
  final String dateFormat;

  RequestToUpdateSettings({this.theme = '', this.dateFormat = ''});
}
