part of 'app_navigator_bloc.dart';

abstract class AppNavigatorState extends Equatable {
  const AppNavigatorState();

  @override
  List<Object> get props => [];
}

class InitialAppNavigatorState extends AppNavigatorState {}

class AppPageState extends AppNavigatorState {
  final AppNavigatorPage tab;

  const AppPageState({this.tab});

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'AppPageState {tab: $tab}';
}

class WarnUserState extends AppNavigatorState {
  final List<String> actions;
  final String message;
  final Duration duration;

  const WarnUserState(this.actions,
      {this.message, this.duration = const Duration(seconds: 2)});

  @override
  List<Object> get props => [actions, message, duration];

  @override
  String toString() =>
      'WarnUserState { actions: $actions, message: $message, duration: $duration }';
}

class CoinsLoaded extends AppNavigatorState {
  final List<Coin> coins;
  const CoinsLoaded({this.coins});

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'CoinsLoaded {coins: $coins}';
}