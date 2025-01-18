import 'package:app_show_images/src/data/routes/infraestructura/images_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Estados del Cubit
abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<dynamic> items;

  ImagesLoaded(this.items);
}

class ImagesError extends ImagesState {
  final String message;

  ImagesError(this.message);
}

// Cubit para manejar los estados
class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());

  final String baseUrl =
      'https://api.flickr.com/services/feeds/photos_public.gne';

  Future<void> fetchImages(String tags) async {
    final url = Uri.parse('$baseUrl?tags=$tags&format=json&nojsoncallback=1');

    emit(ImagesLoading()); // Cambiamos el estado a "cargando"

    try {
      // Realizamos la solicitud HTTP con encabezados
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'app_show_images/1.0.0+1',
      });

      if (response.statusCode == 200) {
        final jsonBody = response.body;
        final jsonResponse = jsonDecode(jsonBody);
        final itemsJson = jsonResponse['items'] as List<dynamic>;
        // Convertimos el JSON en una lista de objetos `Item`
        final items = itemsJson.map((item) => Item.fromJson(item)).toList();
        emit(ImagesLoaded(
            items)); // Cambiamos el estado a "cargado" con los datos
      } else {
        emit(ImagesError(
            'Failed to fetch images. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ImagesError('Failed to fetch images. Error: $e'));
    }
  }
}
