import 'package:app_show_images/src/data/routes/infraestructura/images_dto.dart';

class ImageState {
  final String status;
  final List<Item> items;
  final String errorMessage;

  // Constructor con parámetros requeridos
  ImageState({
    required this.status,
    required this.items,
    this.errorMessage = '',
  });

  // Método para copiar el estado actual y modificar solo algunos valores
  ImageState copyWith({
    String? status,
    List<Item>? items,
    String? errorMessage,
  }) {
    return ImageState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory ImageState.initial() {
    return ImageState(
      status: 'initial',
      items: [], // Lista vacía inicial
      errorMessage: 'null',
    );
  }
}
