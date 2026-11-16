import 'package:education_children/feature/home/model/home_dashboard_model.dart';
import 'package:education_children/feature/home/model/islands_response_model.dart';
import 'package:education_children/feature/island/model/island_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeDashboardModel? dashboard;
  final IslandsResponseModel? islandsApi;
  final List<IslandModel> islands;
  final IslandModel activeIsland;
  final int coins;
  final int stars;
  final String childName;

  HomeSuccessState({
    this.dashboard,
    this.islandsApi,
    required this.islands,
    required this.activeIsland,
    required this.coins,
    required this.stars,
    required this.childName,
  });
}

class HomeErrorState extends HomeState {
  final String message;
  final List<IslandModel> fallbackIslands;

  HomeErrorState({
    required this.message,
    required this.fallbackIslands,
  });
}
