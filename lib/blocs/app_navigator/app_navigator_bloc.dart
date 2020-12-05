import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/coin.dart';
import '../../models/main_repository.dart';
import '../../shared/app_defaults.dart';
import '../../shared/common_utils.dart';

part 'app_navigator_event.dart';
part 'app_navigator_state.dart';

class AppNavigatorBloc extends Bloc<AppNavigatorEvent, AppNavigatorState> {
  MainRepository _mainRepository;
  AppNavigatorBloc({@required MainRepository mainRepository})
      : assert(mainRepository != null),
        _mainRepository = mainRepository,
        super(InitialAppNavigatorState());

  @override
  Stream<AppNavigatorState> mapEventToState(AppNavigatorEvent event) async* {
    if (event is AppPageEvent) {
      yield AppPageState(tab: event.tab);
    } else if (event is AnonymousSigninEvent) {
      yield* _signInAnonymously(event);
    } else if (event is WarnUserEvent) {
      // NB! implement this further if necessary
      yield WarnUserState(event.actions,
          message: event.message, duration: event.duration);
    } else if (event is LoadCoinsEvent) {
      yield* _loadCoins(event);
    }
  }

  Stream<CoinsLoaded> _loadCoins(LoadCoinsEvent event) async* {
    List<Coin> coins = await _mainRepository.apiGetCoins(
        start: event.start, limit: event.limit);

    yield CoinsLoaded(coins: coins);
  }

  Stream<AppNavigatorState> _signInAnonymously(
      AnonymousSigninEvent event) async* {
    String userId = _mainRepository.hiveStore.read("USERID");
    if (CommonUtils.nullSafe(userId).isEmpty ||
        FirebaseAuth.instance.currentUser == null) {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      CommonUtils.logger.d("userCredential: $userCredential");
      /*
    userCredential: UserCredential(additionalUserInfo: AdditionalUserInfo(
      isNewUser: true, profile: {}, providerId: null, username: null), credential: null,
      user: User(displayName: null, email: null, emailVerified: false,
          isAnonymous: true,
          metadata: UserMetadata(creationTime: 2020-11-17 21:58:34.418, lastSignInTime: 2020-11-17 21:58:34.418),
              phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null,
              uid: RsLrKJkEcyPY9Dpr8nAIjHynTLD2)
          )
     */

      userId = userCredential.user.uid;
      _mainRepository.hiveStore.save("USERID", userId);
    }

    /* // b! this can be used later on
    add(WarnUserEvent(List<String>()..add("alert_message")..add("WARN"),
        message: "Welcome anonymous! $userId", duration: Duration(seconds: 3)));
    */
  }
}
