import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentPagePod = StateNotifierProvider<CurrentPageNotifier, int>(
  (_) => CurrentPageNotifier(),
);

class CurrentPageNotifier extends StateNotifier<int> {
  CurrentPageNotifier() : super(0);

  int update(int _page) => state = _page;
}
