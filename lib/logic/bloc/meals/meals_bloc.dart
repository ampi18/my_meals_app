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
  String? searchText;

  bool isFirstRquest = true;

  MealsBloc() : super(MealsInitial()) {
    on<RequestToLoadMeals>(_loadMeals);

    on<RequestToLoadSingleMeal>(_loadSingleMeal);

    on<RequestToUpdateMeal>(_updateMeal);

    on<RequestToEditMeal>(_editMeal);

    on<RequestToAddMeal>(_addMeal);
  }

  _loadMeals(RequestToLoadMeals event, Emitter<MealsState> emit) async {
    emit(LoadingMeals());

    if (isFirstRquest) {
      await _databaseService.populateData();
      isFirstRquest = false;
    }

    isAscending = event.ascending ?? isAscending;
    displayedRatings = event.ratings ?? displayedRatings;
    displayedMealTimes = event.mealTimes ?? displayedMealTimes;
    displayedOrigins = event.origins ?? displayedOrigins;
    searchText = event.searchText ?? searchText;

    await loadMealsFromDB().then((meals) => emit(MealsLoaded(
        meals: meals,
        isAscending: isAscending,
        displayedRatings: displayedRatings,
        displayedMealTimes: displayedMealTimes,
        displayedOrigins: displayedOrigins,
        searchText: searchText)));
  }

  _loadSingleMeal(
      RequestToLoadSingleMeal event, Emitter<MealsState> emit) async {
    emit(LoadingSingleMeal());
    await loadSingleMealFromDB(event.id)
        .then((meal) => emit(SingleMealLoaded(meal, readOnly: true)));
  }

  _updateMeal(RequestToUpdateMeal event, Emitter<MealsState> emit) async {
    emit(UpdatingMeal());
    if (event.meal.id == 0) {
      await insertMealInDB(event.meal)
          .then((value) => add(RequestToLoadSingleMeal(id: value)));
    } else {
      await updateMealInDB(event.meal)
          .then((value) => add(RequestToLoadSingleMeal(id: event.meal.id)));
    }
  }

  _editMeal(RequestToEditMeal event, Emitter<MealsState> emit) {
    emit(SingleMealLoaded(event.meal, readOnly: false));
  }

  _addMeal(RequestToAddMeal event, Emitter<MealsState> emit) {
    emit(SingleMealLoaded(
        Meal(
          id: 0,
          name: '',
          rating: 1,
          mealTime: MealTime.breakfast,
          origin: Origin.homecooked,
          source: '',
          date: DateTime.now(),
        ),
        readOnly: false));
  }

  Future<List<Meal>> loadMealsFromDB() async {
    return await _databaseService.meals(
        ascending: isAscending,
        ratings: displayedRatings,
        mealTimes: displayedMealTimes,
        origins: displayedOrigins,
        searchText: searchText);
  }

  Future<Meal> loadSingleMealFromDB(int id) async {
    return await _databaseService.meal(id);
  }

  Future<int> insertMealInDB(Meal meal) async {
    return await _databaseService.insertMeal(meal);
  }

  Future<void> updateMealInDB(Meal meal) async {
    return await _databaseService.updateMeal(meal);
  }
}
