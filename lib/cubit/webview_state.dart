part of 'webview_cubit.dart';

abstract class WebviewState {}

class WebviewInitial extends WebviewState {}
class WebviewLoading extends WebviewState {}

class WebviewLoaded extends WebviewState {
  final String url;

  WebviewLoaded({required this.url});
}

class WebviewEmptyURL extends WebviewState {}

class WebviewError extends WebviewState {
  final String message;

  WebviewError({required this.message});
}
