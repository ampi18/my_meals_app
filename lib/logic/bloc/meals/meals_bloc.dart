import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_meals_app/database/database.dart';

import 'package:my_meals_app/logic/models/meal.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';
import 'package:my_meals_app/logic/models/origin.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final DatabaseService _databaseService = DatabaseService();

  bool isAscending = true;
  List<int> displayedRatings = List<int>.generate(5, (index) => index + 1);
  List<int> displayedMealTimes = List<int>.generate(4, (index) => index);
  List<int> displayedOrigins = List<int>.generate(4, (index) => index);
  String searchText = '';

  MealsBloc() : super(MealsInitial()) {
    _databaseService.populateData();
    on<RequestToLoadMeals>(_loadMeals);
    // on<RequestToPopulateDatabase>((event, emit) async {
    //   await _databaseService.populateData();
    // });
    on<RequestToLoadSingleMeal>(_loadSingleMeal);

    on<RequestToUpdateMeal>(_updateMeal);

    on<RequestToEditMeal>((event, emit) async {
      emit(SingleMealLoaded(event.meal, readOnly: false));
    });

    on<RequestToAddMeal>((event, emit) async {
      emit(SingleMealLoaded(
          Meal(
            id: 0,
            name: '',
            rating: 0,
            mealTime: MealTime.breakfast,
            origin: Origin.homecooked,
            source: '',
            date: DateTime.now(),
          ),
          readOnly: false));
    });
  }

  _loadMeals(RequestToLoadMeals event, Emitter<MealsState> emit) async {
    emit(LoadingMeals());
    isAscending = event.ascending;
    displayedRatings = event.ratings ?? displayedRatings;
    displayedMealTimes = event.mealTimes ?? displayedMealTimes;
    displayedOrigins = event.origins ?? displayedOrigins;
    searchText = event.searchText;
    await loadMealsFromDB().then((meals) => emit(MealsLoaded(meals)));
  }

  Future<List<Meal>> loadMealsFromDB() async {
    return await _databaseService.meals(
        ascending: isAscending,
        ratings: displayedRatings,
        mealTimes: displayedMealTimes,
        origins: displayedOrigins,
        searchText: searchText);
  }

  _loadSingleMeal(
      RequestToLoadSingleMeal event, Emitter<MealsState> emit) async {
    emit(LoadingSingleMeal());
    final meal = await _databaseService.meal(event.id);
    emit(SingleMealLoaded(meal, readOnly: true));
  }

  _updateMeal(RequestToUpdateMeal event, Emitter<MealsState> emit) async {
    emit(UpdatingMeal());
    if (event.meal.id == 0) {
      await _databaseService
          .insertMeal(event.meal)
          .then((value) => add(RequestToLoadSingleMeal(id: value)));
    } else {
      await _databaseService
          .updateMeal(event.meal)
          .then((value) => add(RequestToLoadSingleMeal(id: event.meal.id)));
    }
  }
}
