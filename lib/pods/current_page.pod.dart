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
    final List<CurrentPageState> _state = state;
    _state.remove(_state.last);

    return _state;
  }

  List<CurrentPageState> update(CurrentPageState newState) {
    // * add newState to go as current entry to the state
    final List<CurrentPageState> _state = state;
    _state.add(newState);

    return _state;
  }
}
