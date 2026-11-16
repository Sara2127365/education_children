import 'package:education_children/core/network/api_constants.dart';
import 'package:education_children/core/network/api_service.dart';
import 'package:education_children/core/state/user_profile_state.dart';
import 'package:education_children/feature/home/cubit/home_state.dart';
import 'package:education_children/feature/home/model/home_dashboard_model.dart';
import 'package:education_children/feature/home/model/islands_response_model.dart';
import 'package:education_children/feature/island/model/island_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<IslandModel> _currentIslands = List.from(islands);

  /// جلب بيانات الهوم والجزر من الـ API
  Future<void> fetchHomeData() async {
    emit(HomeLoadingState());

    try {
      HomeDashboardModel? dashboard;
      IslandsResponseModel? islandsResponse;

      // 1. جلب بيانات لوحة التحكم (Home Dashboard)
      try {
        final homeJson = await ApiService.get(
          url: '${ApiConstants.baseUrl}${ApiConstants.home}',
        );
        dashboard = HomeDashboardModel.fromJson(homeJson);
      } catch (_) {
        // الاستمرار في حال تعذر الوصول للمسار الأول
      }

      // 2. جلب خريطة الجزر والتقدم (Islands Engine)
      try {
        final islandsJson = await ApiService.get(
          url: '${ApiConstants.baseUrl}${ApiConstants.islands}',
        );
        islandsResponse = IslandsResponseModel.fromJson(islandsJson);
      } catch (_) {
        // الاستمرار في حال تعذر الوصول للمسار الثاني
      }

      // 3. استخراج البيانات المحدثة
      final resolvedName = dashboard?.childName ??
          (UserProfile.name.value.isNotEmpty ? UserProfile.name.value : 'عمر');

      final resolvedCoins = islandsResponse?.totalCoins != null && islandsResponse!.totalCoins > 0
          ? islandsResponse.totalCoins
          : (dashboard?.totalCoins ?? UserProfile.coins.value);

      final resolvedStars = islandsResponse?.totalStars != null && islandsResponse!.totalStars > 0
          ? islandsResponse.totalStars
          : (dashboard?.totalStars ?? UserProfile.stars.value);

      // دمج حالة القفل والفتح للجزر من السيرفر
      if (islandsResponse != null && islandsResponse.islands.isNotEmpty) {
        _currentIslands = _mergeIslandsWithApi(islandsResponse.islands);
      }

      // تحديد الجزيرة النشطة التي يشير إليها السهم
      IslandModel active = _currentIslands.first;
      if (dashboard != null && dashboard.currentIsland.isNotEmpty) {
        active = _findActiveIsland(dashboard.currentIsland);
      } else {
        // البحث عن أول جزيرة غير مكتملة أو آخر جزيرة مفتوحة
        active = _currentIslands.firstWhere(
          (i) => i.locked,
          orElse: () => _currentIslands.first,
        );
      }

      // تحديث حالة Core في UserProfile
      UserProfile.update(
        newName: resolvedName,
        newCoins: resolvedCoins,
        newStars: resolvedStars,
      );

      emit(HomeSuccessState(
        dashboard: dashboard,
        islandsApi: islandsResponse,
        islands: _currentIslands,
        activeIsland: active,
        coins: resolvedCoins,
        stars: resolvedStars,
        childName: resolvedName,
      ));
    } catch (e) {
      emit(HomeErrorState(
        message: e.toString().replaceAll('Exception: ', ''),
        fallbackIslands: _currentIslands,
      ));
    }
  }

  /// إعادة تحديث البيانات في الخلفية
  Future<void> refresh() async {
    await fetchHomeData();
  }

  /// دمج حالة الجزر من الـ API مع إحداثيات الخريطة الدقيقة
  List<IslandModel> _mergeIslandsWithApi(List<IslandItemModel> apiIslands) {
    final updated = <IslandModel>[];

    for (int i = 0; i < islands.length; i++) {
      final local = islands[i];
      // محاولة المطابقة عبر المعرف أو العنوان
      final matched = apiIslands.firstWhere(
        (api) {
          final id = api.id.toLowerCase();
          final title = api.title;
          if (i == 0 && (id.contains('char') || title.contains('حروف'))) return true;
          if (i == 1 && (id.contains('move') || title.contains('حركات'))) return true;
          if (i == 2 && (id.contains('stretch') || title.contains('مد'))) return true;
          if (i == 3 && (id.contains('word') || title.contains('كلمات'))) return true;
          if (i == 4 && (id.contains('rule') || title.contains('قواعد') || title.contains('جمل'))) return true;
          if (i == 5 && (id.contains('treas') || title.contains('كنز'))) return true;
          return false;
        },
        orElse: () => IslandItemModel(
          id: '',
          title: '',
          progressPercentage: 0,
          isUnlocked: local.locked == false,
        ),
      );

      // جزيرة الحروف والكنز مفتوحتان أو بحسب السيرفر
      final isUnlocked = (i == 0 || i == 5) ? true : matched.isUnlocked;

      updated.add(local.copyWith(locked: !isUnlocked));
    }

    return updated;
  }

  /// البحث عن الجزيرة النشطة بناءً على الاسم أو المعرف
  IslandModel _findActiveIsland(String islandQuery) {
    final q = islandQuery.toLowerCase();
    for (int i = 0; i < _currentIslands.length; i++) {
      final isl = _currentIslands[i];
      if (q.contains('حركات') || q.contains('move')) {
        if (i == 1) return isl;
      } else if (q.contains('مد') || q.contains('stretch')) {
        if (i == 2) return isl;
      } else if (q.contains('كلم') || q.contains('word')) {
        if (i == 3) return isl;
      } else if (q.contains('قواعد') || q.contains('جمل') || q.contains('rule')) {
        if (i == 4) return isl;
      } else if (q.contains('كنز') || q.contains('treas')) {
        if (i == 5) return isl;
      } else if (q.contains('حروف') || q.contains('char')) {
        if (i == 0) return isl;
      }
    }
    return _currentIslands.first;
  }
}
