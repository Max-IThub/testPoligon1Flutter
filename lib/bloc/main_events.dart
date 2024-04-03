abstract class MainEvent {}

class LoadingEvent extends MainEvent {}

class DeleteEvent extends MainEvent {
  DeleteEvent({required this.index});
  final int index;
}

class NavigateToScreenEvent extends MainEvent {
  NavigateToScreenEvent({required this.index});
  final int index;
}