import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  String theme = 'light';
  String dateFormat = 'dd.MM.yyyy';

  SettingsBloc() : super(SettingsInitial()) {
    on<RequestToLoadSettings>((event, emit) async {
      emit(LoadingSettings());
      await SharedPreferences.getInstance().then((prefs) {
        theme = prefs.getString('theme') ?? 'light';
        dateFormat = prefs.getString('dateFormat') ?? 'dd.MM.yyyy';
        emit(SettingsLoaded(theme, dateFormat));
      });

      on<RequestToUpdateSettings>((event, emit) async {
        await SharedPreferences.getInstance().then((prefs) async {
          if (event.theme.isNotEmpty) {
            await prefs.setString('theme', event.theme);
            theme = event.theme;
          }
          if (event.dateFormat.isNotEmpty) {
            await prefs.setString('dateFormat', event.dateFormat);
            dateFormat = event.dateFormat;
          }

          emit(SettingsLoaded(theme, dateFormat));
        });
      });
    });
  }
}
