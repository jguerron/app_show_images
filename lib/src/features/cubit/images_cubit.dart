import 'package:app_show_images/src/data/routes/infraestructura/images_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<Item> items;

  ImagesLoaded(this.items);
}

class ImagesError extends ImagesState {
  final String message;

  ImagesError(this.message);
}

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());

  Future<void> fetchImages() async {
    emit(ImagesLoading());
    try {
      final response = await http.get(
        Uri.parse(
            "https://api.flickr.com/services/feeds/photos_public.gne?tags=priime&format=json&nojsoncall"),
      );

      if (response.statusCode == 200) {
        // Elimina el prefijo `jsonFlickrFeed(` y el sufijo `)`
        final rawData = response.body;
        final jsonString = rawData
            .replaceFirst('jsonFlickrFeed(', '')
            .replaceFirst(RegExp(r'\)$'), '');

        // Convierte la cadena JSON válida en un objeto
        final data = json.decode(jsonString);
        final imagesResponse = Welcome.fromJson(data);

        emit(ImagesLoaded(imagesResponse.items ?? []));
      } else {
        emit(ImagesError(
            "Failed to fetch images. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ImagesError("Error: $e"));
    }
  }
}
