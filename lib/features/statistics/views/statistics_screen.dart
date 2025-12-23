import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/helpers/week_range.dart';

import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/statistics/providers/retrieve_revival_retro_statistics_controller.dart';
import 'package:gamelog/features/statistics/providers/retrieve_trend_statistics_controller.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/domain/entities/game.dart';
import '../../../core/helpers/failure_handler.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_graph.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_skeleton_loader.dart';
import '../providers/search_game_controller.dart';

final searchTrendResultProvider = StateProvider.autoDispose<List<Game?>>(
  (ref) => [],
);

final retrieveTrendResultsProvider = StateProvider.autoDispose<List<Game>>(
  (ref) => [],
);

final searchRevivalRetroResultProvider = StateProvider.autoDispose<List<Game?>>(
  (ref) => [],
);

final retrieveRevivalRetroResultsProvider =
    StateProvider.autoDispose<List<Game>>((ref) => []);

final mergedTrendGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(retrieveTrendResultsProvider);
  final detailedGames = ref.watch(searchTrendResultProvider);

  final detailedById = {for (final game in detailedGames) game?.id: game};

  return games.map((game) {
    final detailed = detailedById[game.id];
    if (detailed == null) return game;

    return game.copyWith(
      name: detailed.name,
      backgroundImage: detailed.backgroundImage ?? '',
    );
  }).toList();
});

final mergedRevivalRetroGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(retrieveRevivalRetroResultsProvider);
  final detailedGames = ref.watch(searchRevivalRetroResultProvider);

  final detailedById = {for (final game in detailedGames) game?.id: game};

  return games.map((game) {
    final detailed = detailedById[game.id];
    if (detailed == null) return game;

    return game.copyWith(
      name: detailed.name,
      backgroundImage: detailed.backgroundImage ?? '',
    );
  }).toList();
});

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  late final ProviderSubscription _searchTrendGameSub;
  late final ProviderSubscription _retrieveTrendGameSub;
  late final ProviderSubscription _searchRevivalRetroGameSub;
  late final ProviderSubscription _retrieveRevivalRetroGameSub;
  WeekRange week = getCurrentWeekRange();
  late DateTime? trendEndDate = week.end;
  late DateTime? trendStartDate = week.start;
  late DateTime? revivalRetroEndDate = week.end;
  late DateTime? revivalRetroStartDate = week.start;
  late String? _trendSelectedRange = '${DateFormat('dd/MM/yyyy').format(trendStartDate!)}'
      ' - '
      '${DateFormat('dd/MM/yyyy').format(trendEndDate!)}';
  late String? _revivalRetroSelectedRange = '${DateFormat('dd/MM/yyyy').format(revivalRetroStartDate!)}'
      ' - '
      '${DateFormat('dd/MM/yyyy').format(revivalRetroEndDate!)}';
  bool notFoundTrendStatistics = false;
  bool notFoundRevivalRetroStatistics = false;

  Future<void> _reloadTrendStatistics() async {
    if (!mounted || trendStartDate == null || trendEndDate == null) return;

    setState(() => notFoundTrendStatistics = false);

    ref.read(searchTrendResultProvider.notifier).state = [];
    ref.read(retrieveTrendResultsProvider.notifier).state = [];

    await ref
        .read(retrieveTrendStatisticsControllerProvider.notifier)
        .retrieveTrendStatistics(trendStartDate!, trendEndDate!);
  }

  Future<void> _reloadRevivalRetroStatistics() async {
    if (!mounted ||
        revivalRetroStartDate == null ||
        revivalRetroEndDate == null) {
      return;
    }

    setState(() => notFoundRevivalRetroStatistics = false);

    ref.read(searchRevivalRetroResultProvider.notifier).state = [];
    ref.read(retrieveRevivalRetroResultsProvider.notifier).state = [];

    await ref
        .read(retrieveRevivalRetroStatisticsControllerProvider.notifier)
        .retrieveRevivalRetroStatistics(
          revivalRetroStartDate!,
          revivalRetroEndDate!,
        );
  }

  Future<void> _searchTrendGame(String query) async {
    await ref
        .read(searchTrendGameControllerProvider.notifier)
        .searchGame(query);
  }

  Future<void> _searchRevivalRetroGame(String query) async {
    await ref
        .read(searchRevivalRetroGameControllerProvider.notifier)
        .searchGame(query);
  }

  @override
  void initState() {
    super.initState();

    _searchTrendGameSub = ref.listenManual<AsyncValue<Game?>>(
      searchTrendGameControllerProvider,
      _onSearchTrendGameChanged,
    );

    _searchRevivalRetroGameSub = ref.listenManual<AsyncValue<Game?>>(
      searchRevivalRetroGameControllerProvider,
      _onSearchRevivalRetroGameChanged,
    );
    _retrieveTrendGameSub = ref
        .listenManual<AsyncValue<RetrieveStatisticsResponse?>>(
          retrieveTrendStatisticsControllerProvider,
          _onRetrieveTrendStatisticsChanged,
        );

    _retrieveRevivalRetroGameSub = ref
        .listenManual<AsyncValue<RetrieveStatisticsResponse?>>(
          retrieveRevivalRetroStatisticsControllerProvider,
          _onRetrieveRevivalRetroStatisticsChanged,
        );

    Future.microtask(_reloadTrendStatistics);
    Future.microtask(_reloadRevivalRetroStatistics);
  }

  @override
  void dispose() {
    _retrieveTrendGameSub.close();
    _searchTrendGameSub.close();
    _retrieveRevivalRetroGameSub.close();
    _searchRevivalRetroGameSub.close();
    super.dispose();
  }

  void _onSearchTrendGameChanged(
    AsyncValue<Game?>? previous,
    AsyncValue<Game?> next,
  ) {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          final notifier = ref.read(searchTrendResultProvider.notifier);
          notifier.state = [...notifier.state, response];
        },
        error: (error, __) {},
      );
    }
  }

  void _onSearchRevivalRetroGameChanged(
    AsyncValue<Game?>? previous,
    AsyncValue<Game?> next,
  ) {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          final notifier = ref.read(searchRevivalRetroResultProvider.notifier);
          notifier.state = [...notifier.state, response];
        },
        error: (error, __) {},
      );
    }
  }

  void _onRetrieveTrendStatisticsChanged(
    AsyncValue<RetrieveStatisticsResponse?>? previous,
    AsyncValue<RetrieveStatisticsResponse?> next,
  ) async {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (response == null) return;

          if (response.games.isEmpty) {
            setState(() => notFoundTrendStatistics = true);
          } else {
            for (int i = 0; i < response.games.length; i++) {
              await _searchTrendGame(response.games[i].name);
            }
          }

          ref.read(retrieveTrendResultsProvider.notifier).state =
              response.games;
        },
        error: (error, __) {
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  void _onRetrieveRevivalRetroStatisticsChanged(
    AsyncValue<RetrieveStatisticsResponse?>? previous,
    AsyncValue<RetrieveStatisticsResponse?> next,
  ) async {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (response == null) return;

          if (response.games.isEmpty) {
            setState(() => notFoundRevivalRetroStatistics = true);
          } else {
            for (int i = 0; i < response.games.length; i++) {
              await _searchRevivalRetroGame(response.games[i].name);
            }
          }

          ref.read(retrieveRevivalRetroResultsProvider.notifier).state =
              response.games;
        },
        error: (error, __) {
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  Future<void> _selectTrendDateRange(BuildContext context) async {
    showCustomDateRangePicker(
      context,
      dismissible: true,
      minimumDate: DateTime.now().subtract(const Duration(days: 30)),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: trendEndDate,
      startDate: trendStartDate,
      backgroundColor: AppColors.surface,
      primaryColor: AppColors.primary,
      onApplyClick: (start, end) {
        setState(() {
          trendEndDate = end;
          trendStartDate = start;
        });
        setState(
          () => _trendSelectedRange =
              '${DateFormat('dd/MM/yyyy').format(trendStartDate!)}'
              ' - '
              '${DateFormat('dd/MM/yyyy').format(trendEndDate!)}',
        );
        _reloadTrendStatistics();
      },
      onCancelClick: () {
        setState(() {
          trendEndDate = null;
          trendStartDate = null;
        });
        setState(() => _trendSelectedRange = null);
      },
    );
  }

  Future<void> _selectRevivalRetroDateRange(BuildContext context) async {
    showCustomDateRangePicker(
      context,
      dismissible: true,
      minimumDate: DateTime.now().subtract(const Duration(days: 30)),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: revivalRetroEndDate,
      startDate: revivalRetroStartDate,
      backgroundColor: AppColors.surface,
      primaryColor: AppColors.primary,
      onApplyClick: (start, end) {
        setState(() {
          revivalRetroEndDate = end;
          revivalRetroStartDate = start;
        });
        setState(
              () => _revivalRetroSelectedRange =
          '${DateFormat('dd/MM/yyyy').format(revivalRetroStartDate!)}'
              ' - '
              '${DateFormat('dd/MM/yyyy').format(revivalRetroEndDate!)}',
        );
        _reloadRevivalRetroStatistics();
      },
      onCancelClick: () {
        setState(() {
          revivalRetroEndDate = null;
          revivalRetroStartDate = null;
        });
        setState(() => _revivalRetroSelectedRange = null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final trendMergedGames = ref.watch(mergedTrendGamesProvider);
    final revivalRetroMergedGames = ref.watch(mergedRevivalRetroGamesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.statisticsTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              AppModuleTitle(title: 'Juegos más reseñados}'),
              Text('Echa un vistazo a los jiegos más reseñados de la semana'),
              const SizedBox(height: 24.0),
              GestureDetector(
                onTap: () => _selectTrendDateRange(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 8),
                      Text(_trendSelectedRange ?? 'Seleccionar rango de fecha'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12.0),

              if (trendMergedGames.isNotEmpty)
                AppGraph(games: trendMergedGames, onTap: () {}, title: 'Top res;eados',)
              else if (!notFoundTrendStatistics)
                const AppSkeletonLoader(
                  height: 290,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

              AppModuleTitle(title: 'Juegos retro'),
              Text('Echa un vistazo a los jiegos retros'),
              const SizedBox(height: 24.0),


              GestureDetector(
                onTap: () => _selectRevivalRetroDateRange(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 8),
                      Text(_revivalRetroSelectedRange ?? 'Seleccionar rango de fecha'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12.0),

              if (revivalRetroMergedGames.isNotEmpty)
                AppGraph(games: revivalRetroMergedGames, onTap: () {}, title: 'top retroo',)
              else if (!notFoundRevivalRetroStatistics)
                const AppSkeletonLoader(
                  height: 290,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              const SizedBox(height: 24.0),

            ],
          ),
        ),
      ),
    );
  }
}
