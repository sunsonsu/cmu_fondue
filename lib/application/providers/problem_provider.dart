/*
 * File: problem_provider.dart
 * Description: Primary state management provider aggregating localized problem datasets.
 * Responsibilities: Caches queried problem records, manages reactive UI filtering flags, and routes updates to usecases.
 * Author: Rachata, Komsan, Apiwit, Chananchida
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'dart:io';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/delete_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_user_by_id_usecase.dart';
import 'package:cmu_fondue/data/services/cloud_functions_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Pairs a [problem] with its calculated geospatial [distance] threshold relative to the active mobile device.
class ProblemWithDistance {
  /// The core entity representing the recorded issue.
  final ProblemEntity problem;

  /// The spatial gap in precise meters.
  final double distance;

  /// Initializes a new instance of [ProblemWithDistance].
  ProblemWithDistance(this.problem, this.distance);
}

/// Administers reactive state broadcasting for all community-reported map obstacles over the app hierarchy.
class ProblemProvider with ChangeNotifier {
  final GetProblemsUseCase _getProblemsUseCase;
  final CreateProblemUseCase _createProblemUseCase;
  final UpdateProblemUpvoteUseCase _updateProblemUpvoteUseCase;
  final DeleteProblemUseCase _deleteProblemUseCase;
  final UpdateProblemUseCase _updateProblemUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;
  final CloudFunctionsService _cloudFunctionsService;

  String? _currentUserId;
  bool _isLoading = false;
  List<ProblemEntity> _problems = [];

  ProblemTag? _selectedTag;
  ProblemType? _selectedCategory;

  /// Initializes a new instance of [ProblemProvider].
  ///
  /// Demands broad injections covering core retrieval, editing, and cloud signalling domains.
  ProblemProvider(
    this._getProblemsUseCase,
    this._createProblemUseCase,
    this._updateProblemUpvoteUseCase,
    this._deleteProblemUseCase,
    this._updateProblemUseCase,
    this._getUserByIdUseCase,
    this._cloudFunctionsService,
  );

  /// Whether a heavy network refresh operation is actively spinning.
  bool get isLoading => _isLoading;

  /// The active categorization filter applied strictly against current board statuses.
  ProblemTag? get selectedTag => _selectedTag;

  /// The active categorization filter applied strictly against root hardware/software constraints.
  ProblemType? get selectedCategory => _selectedCategory;

  /// The complete unhindered list representing every record downloaded.
  List<ProblemEntity> get allProblems => _problems;

  /// Retrieves a constrained sublist enforcing the actively chosen tag and category overlays.
  List<ProblemEntity> get filteredProblems {
    if (_selectedTag == null && _selectedCategory == null) return _problems;

    return _problems.where((p) {
      final matchTag = _selectedTag == null || p.tagName == _selectedTag;
      final matchType =
          _selectedCategory == null || p.typeName == _selectedCategory;
      return matchTag && matchType;
    }).toList();
  }

  /// Retrieves a constrained sublist restricted purely to items originally submitted by the active user.
  List<ProblemEntity> get historyProblems {
    return _problems.where((p) => p.reporterId == _currentUserId).toList();
  }

  /// The sheer volume representing records untouched or formally pending review.
  int get countPending =>
      _problems.where((p) => p.tagName == ProblemTag.pending).length;

  /// The sheer volume representing records currently occupying an active repair lifecycle.
  int get countInProgress =>
      _problems.where((p) => p.tagName == ProblemTag.inProgress).length;

  /// The sheer volume representing records fully signed off and cleanly resolved.
  int get countCompleted =>
      _problems.where((p) => p.tagName == ProblemTag.completed).length;

  /// Constrains system views mapping internal lists to exact [tag] or [category] criteria.
  ///
  /// Side effects:
  /// Updates local properties instantly and fires [notifyListeners].
  void setFilters({ProblemTag? tag, ProblemType? category}) {
    _selectedTag = tag;
    _selectedCategory = category;
    notifyListeners();
  }

  /// Generates consolidated analytics identifying the geographical hotspot enduring maximum distress.
  ///
  /// Binds reports possessing identical string locations together summing global upvote totals sequentially.
  Map<String, dynamic> getMostReportedAreaData() {
    if (_problems.isEmpty) {
      return {
        'location': 'ไม่มีข้อมูล',
        'problems': <ProblemEntity>[],
        'upvotes': 0,
      };
    }

    Map<String, List<ProblemEntity>> locationGroups = {};
    for (var problem in _problems) {
      if (!locationGroups.containsKey(problem.locationName)) {
        locationGroups[problem.locationName] = [];
      }
      locationGroups[problem.locationName]!.add(problem);
    }

    String mostReportedLocation = '';
    List<ProblemEntity> mostReportedProblems = [];
    int maxUpvoteSum = -1;

    locationGroups.forEach((location, problemsInArea) {
      int totalUpvotes = problemsInArea.fold(
        0,
        (sum, problem) => sum + problem.upvoteCount,
      );

      if (totalUpvotes > maxUpvoteSum) {
        maxUpvoteSum = totalUpvotes;
        mostReportedLocation = location;
        mostReportedProblems = problemsInArea;
      }
    });

    return {
      'location': mostReportedLocation,
      'problems': mostReportedProblems,
      'upvotes': maxUpvoteSum,
    };
  }

  /// Calculates a strict tally separating existing records exclusively by standard tags.
  Map<ProblemTag, int> getLocalStatistics() {
    return {
      ProblemTag.pending: _problems
          .where((p) => p.tagName == ProblemTag.pending)
          .length,
      ProblemTag.received: _problems
          .where((p) => p.tagName == ProblemTag.received)
          .length,
      ProblemTag.inProgress: _problems
          .where((p) => p.tagName == ProblemTag.inProgress)
          .length,
      ProblemTag.completed: _problems
          .where((p) => p.tagName == ProblemTag.completed)
          .length,
    };
  }

  /// Adjusts the localized reference indicating whom currently commands the context window.
  ///
  /// Side effects:
  /// Assigns the new ID natively and fires [notifyListeners].
  void updateUserId(String? userId) {
    if (_currentUserId == userId) return;
    _currentUserId = userId;
    debugPrint('ProblemProvider updated with userId: $_currentUserId');
    notifyListeners();
  }

  /// Retrieves a constrained sublist actively masking anything definitively marked resolved.
  List<ProblemEntity> get notCompletedProblems =>
      _problems.where((p) => p.tagName != ProblemTag.completed).toList();

  /// Scans physical distance comparing current coordinates against cached problem entities dynamically.
  ///
  /// Enforces a hard spatial limit defaulting [maxDistance] to 500 meters strictly. Use [onlyNotCompleted]
  /// boolean checks to exclude strictly resolved items.
  List<ProblemEntity> getNearbyProblems(
    double lat,
    double lng, {
    double maxDistance = 500,
    bool onlyNotCompleted = false,
  }) {
    final List<ProblemWithDistance> problemsWithDistance = [];
    final sourceList = onlyNotCompleted ? notCompletedProblems : _problems;
    for (var p in sourceList) {
      double distance = Geolocator.distanceBetween(lat, lng, p.lat, p.lng);
      if (distance <= maxDistance) {
        problemsWithDistance.add(ProblemWithDistance(p, distance));
      }
    }
    problemsWithDistance.sort((a, b) => a.distance.compareTo(b.distance));
    return problemsWithDistance.map((e) => e.problem).toList();
  }

  /// Requests a blind wholesale refresh pulling down the complete map dataset anew.
  ///
  /// This operates asynchronously. Safe to ignore network falters cleanly.
  ///
  /// Side effects:
  /// Rewrites the entire [_problems] structure, asserts locking phases via [_isLoading], and fires [notifyListeners] twice.
  Future<void> fetchProblems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _problems = await _getProblemsUseCase(_currentUserId);
    } catch (e) {
      debugPrint('Fetch Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Coordinates consensus additions enforcing real-time binary searches locally tracking priority.
  ///
  /// This operates asynchronously against [problemId]. The true intent flips depending on [isUpvoted].
  /// Throws standard execution errors forward if the remote registry formally drops the ticket.
  ///
  /// Side effects:
  /// Rips out the outdated list item natively swapping its value and fires [notifyListeners].
  Future<void> toggleUpvote({
    required String problemId,
    required bool isUpvoted,
  }) async {
    try {
      await _updateProblemUpvoteUseCase(
        problemId: problemId,
        isUpvoted: isUpvoted,
        userId: _currentUserId,
      );

      final index = _problems.indexWhere((p) => p.id == problemId);
      if (index != -1) {
        final problem = _problems[index];
        final newCount = problem.upvoteCount + (isUpvoted ? 1 : -1);
        _problems[index] = problem.copyWith(
          upvoteCount: newCount < 0 ? 0 : newCount,
          isUpvotedByMe: isUpvoted,
        );
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Triggers a remote, constrained fetch querying strictly [tagId] combined exactly with [typeId].
  ///
  /// This operates asynchronously. Yields a clean empty map list catching all external anomalies securely.
  Future<List<ProblemEntity>> fetchProblemsByTagAndType({
    required String tagId,
    required String typeId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByTagAndType(
        tagId: tagId,
        typeId: typeId,
      );
    } catch (e, stacktrace) {
      print('Fetch by Tag and Type Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  /// Triggers a remote, constrained fetch querying strictly against a definitive [tagId].
  ///
  /// This operates asynchronously. Yields a clean empty map list catching all external anomalies securely.
  Future<List<ProblemEntity>> fetchProblemsByTag({
    required String tagId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByTag(tagId: tagId);
    } catch (e, stacktrace) {
      print('Fetch by Tag Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  /// Triggers a remote, constrained fetch querying strictly against a definitive [typeId].
  ///
  /// This operates asynchronously. Yields a clean empty map list catching all external anomalies securely.
  Future<List<ProblemEntity>> fetchProblemsByType({
    required String typeId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByType(typeId: typeId);
    } catch (e, stacktrace) {
      print('Fetch by Type Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  /// Pushes a brand new map anomaly alongside uploaded media up completely toward the system core.
  ///
  /// This operates asynchronously pushing raw bytes representing [imageFile] outwards initially. Requires
  /// massive structural data ranging from [title] textual explanations towards [lat] precise mappings.
  /// Throws a clear interruption preventing navigation rendering if remote connections fail.
  ///
  /// Side effects:
  /// Explicitly requests a full dataset replacement post-commit, locks using [_isLoading], and calls [notifyListeners] twice.
  Future<void> createProblem({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
    required File imageFile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _createProblemUseCase(
        title: title,
        detail: detail,
        locationName: locationName,
        lat: lat,
        lng: lng,
        reporterId: reporterId,
        typeId: typeId,
        tagId: tagId,
        imageFile: imageFile,
      );
      await fetchProblems();
    } catch (e, stacktrace) {
      print('Create Error: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Interrogates the server solely seeking the highest consensus ranking report dynamically.
  ///
  /// This operates asynchronously. Returns null if failures occur or if the repository explicitly starves results out natively.
  Future<ProblemEntity?> getMaxUpvotedProblem() async {
    try {
      return await _getProblemsUseCase.getMaxUpvotedProblem(_currentUserId);
    } catch (e, stacktrace) {
      print('Get Max Upvoted Problem Error: $e');
      print('Stacktrace: $stacktrace');
      return null;
    }
  }

  /// Queries basic integers aggregating the amount of problems existing exactly on [currentTagId].
  ///
  /// This operates asynchronously against the database. Yields 0 upon sudden network crashes safely.
  Future<int> countProblemsByTag({required String currentTagId}) async {
    try {
      return await _getProblemsUseCase.countByTag(currentTagId);
    } catch (e, stacktrace) {
      print('Count by Tag Error: $e');
      print('Stacktrace: $stacktrace');
      return 0;
    }
  }

  /// Sends strict execution signals demanding immediate erasure utilizing a target [problemId].
  ///
  /// This operates asynchronously. Re-throws any upstream network disruptions causing total failure directly down towards application consumers.
  ///
  /// Side effects:
  /// Tears the matching item structurally out of [_problems] natively and fires [notifyListeners].
  Future<void> deleteProblem({required String problemId}) async {
    try {
      await _deleteProblemUseCase(problemId);

      _problems.removeWhere((p) => p.id == problemId);
      notifyListeners();
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Delete Error: $e');
      }
      if (kDebugMode) {
        print('Stacktrace: $stacktrace');
      }
      rethrow;
    }
  }

  /// Implements highly complex administrator approvals dynamically alerting local devices correctly.
  ///
  /// This operates asynchronously pushing the target [problemId] over to a [newTag] definition. Additionally
  /// retrieves origin citizen metadata invoking remote Firebase Cloud interactions actively forwarding
  /// status strings directly onto physical cellphones properly.
  /// Formal exception propagation bubbles outward notifying UI boundaries exclusively mapping true failures securely.
  ///
  /// Side effects:
  /// Rewrites the single specified internal list record actively and fires [notifyListeners].
  Future<void> changeProblemTag({
    required String problemId,
    required ProblemTag newTag,
  }) async {
    try {
      await _updateProblemUseCase.call(id: problemId, tagId: newTag.tagId);

      final index = _problems.indexWhere((p) => p.id == problemId);
      if (index != -1) {
        final problem = _problems[index];

        try {
          final reporter = await _getUserByIdUseCase.call(problem.reporterId);

          if (reporter?.fcmToken != null && reporter!.fcmToken!.isNotEmpty) {
            try {
              await _cloudFunctionsService.sendProblemStatusNotification(
                problemId: problemId,
                problemTitle: problem.title,
                newTagName: newTag.labelTh,
                fcmToken: reporter.fcmToken!,
              );
              if (kDebugMode) {
                print('✅ Notification sent to reporter');
              }
            } catch (e) {
              if (kDebugMode) {
                print('⚠️ ส่ง notification ไม่สำเร็จ: $e');
              }
            }
          } else {
            if (kDebugMode) {
              print('⚠️ Reporter ไม่มี fcmToken');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('⚠️ ดึงข้อมูล reporter ไม่สำเร็จ: $e');
          }
        }

        _problems[index] = problem.copyWith(tagName: newTag);
        notifyListeners();
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Change Tag Error: $e');
      }
      if (kDebugMode) {
        print('Stacktrace: $stacktrace');
      }
      rethrow;
    }
  }
}
