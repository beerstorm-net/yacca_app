part of 'app_navigator_bloc.dart';

abstract class AppNavigatorEvent extends Equatable {
  const AppNavigatorEvent();

  @override
  List<Object> get props => [];
}

class AnonymousSigninEvent extends AppNavigatorEvent {}

class LoadCoinsEvent extends AppNavigatorEvent {
  final String start;
  final String limit;
  const LoadCoinsEvent({this.start, this.limit});

  @override
  List<Object> get props => [start, limit];

  @override
  String toString() => 'LoadCoinsEvent {start: $start, limit: $limit}';
}

class LoadCoinEvent extends AppNavigatorEvent {
  final String coinId;
  const LoadCoinEvent({this.coinId});

  @override
  List<Object> get props => [coinId];

  @override
  String toString() => 'LoadCoinEvent {coinId: $coinId}';
}

class AppPageEvent extends AppNavigatorEvent {
  final AppNavigatorPage tab;

  const AppPageEvent({this.tab});

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'AppPageEvent {tab: $tab}';
}

class WarnUserEvent extends AppNavigatorEvent {
  final List<String> actions;
  final String message;
  final Duration duration;

  const WarnUserEvent(this.actions,
      {this.message, this.duration = const Duration(seconds: 2)});

  @override
  List<Object> get props => [actions, message, duration];

  @override
  String toString() =>
      'WarnUserEvent { actions: $actions, message: $message, duration: $duration }';
}
