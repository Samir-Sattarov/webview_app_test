import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_app_test/core/api/api_client.dart';
import 'package:webview_app_test/core/api/api_constants.dart';
import 'package:webview_app_test/core/services/storage_service.dart';

part 'webview_state.dart';

class WebviewCubit extends Cubit<WebviewState> {
  late ApiClient apiClient;
  late StorageService storageService;

  WebviewCubit() : super(WebviewInitial()) {
    apiClient = ApiClient();
    storageService = StorageService();
  }

  load() async {
    try {
      emit(WebviewLoading());

      final localData  = await storageService.get("url");

      if(localData != null) {

        if (localData.toString().isNotEmpty) {
          emit(WebviewLoaded(url: localData));
          return;

        } else {
          emit(WebviewEmptyURL());
        }
      }

      final data = await apiClient.get(ApiConstants.url);

      if (data.toString().isNotEmpty) {
        storageService.save("url", data);
        emit(WebviewLoaded(url: data));
      } else {
        emit(WebviewEmptyURL());
      }
    } catch (error) {
      emit(WebviewError(message: error.toString()));
    }
  }


}
