import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/current_page.enum.dart';
import '../states/current_page.state.dart';

// * maintain page history with a list of CURRENT_PAGE
final currentPagePod =
    StateNotifierProvider<CurrentPageNotifier, List<CurrentPageState>>(
  (_) => CurrentPageNotifier(),
);

class CurrentPageNotifier extends StateNotifier<List<CurrentPageState>> {
  CurrentPageNotifier()
      : super(
          [
            CurrentPageState(
              CURRENT_PAGE.home,
              CURRENT_PAGE.home.toPath(),
            )
          ],
        );

  List<CurrentPageState> remove() {
    // * remove last entry to go back
    final pageStates = state;
    pageStates.remove(pageStates.last);

    return pageStates;
  }

  List<CurrentPageState> update(CurrentPageState newState) {
    // * add newState to go as current entry to the state
    final pageStates = state;
    pageStates.add(newState);

    return pageStates;
  }
}
