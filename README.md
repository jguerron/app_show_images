# Show Images App

## Descripción General

Esta aplicación en Flutter permite consumir y mostrar datos provenientes de una API que proporciona información sobre imágenes y sus metadatos. La aplicación utiliza un diseño limpio y eficiente basado en la arquitectura BloC (Business Logic Component) para manejar el estado de la aplicación.

---

## Requisitos Previos

Antes de compilar y ejecutar la aplicación, asegúrese de tener instalados:

- Flutter SDK ([Instrucciones de instalación](https://docs.flutter.dev/get-started/install))
- Dart SDK (se incluye con Flutter)
- Un editor de código compatible, como Visual Studio Code o Android Studio
- Un emulador o dispositivo físico configurado para probar la aplicación

---

## Instrucciones para Compilar y Ejecutar

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/jguerron/app_show_images.git
   cd app_show_images
   ```

2. **Instalar las dependencias**
   Ejecuta el siguiente comando en la carpeta del proyecto para instalar todas las librerías necesarias:
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   - Para ejecutar en un emulador o dispositivo físico conectado, usa:
     ```bash
     flutter run
     ```
   - Si deseas generar un archivo APK para dispositivos Android, ejecuta:
     ```bash
     flutter build apk --release
     ```
   - Para compilar para iOS (en macOS):
     ```bash
     flutter build ios
     ```

---

## Arquitectura Propuesta

La aplicación utiliza la arquitectura **BloC (Business Logic Component)**, que separa la lógica de negocio de la interfaz de usuario, asegurando un código más modular, mantenible y testable.

### Componentes Clave

1. **Cubit**
   - Gestiona el estado de la aplicación.
   - Se utiliza para realizar solicitudes a la API y manejar las respuestas (cargando, éxito, error).

2. **Modelo (DTO)**
   - Representa la estructura de los datos obtenidos de la API.
   - Facilita la conversión entre JSON y objetos de Dart.

3. **Pantallas**
   - Diseñados para mostrar el contenido basado en el estado actual proporcionado por el Cubit.

4. **Integración con la API**
   - La aplicación consume datos JSON desde la API, los convierte a modelos de Dart y los presenta en la interfaz.

---

## Librerías Usadas

### Principales Librerías

1. **flutter_bloc**
   - Facilita la implementación de la arquitectura BloC.
   - Proporciona herramientas para manejar estados y eventos de forma reactiva.
   
   **Beneficio:**
   - Simplifica el manejo del estado, asegurando un flujo de datos predecible y estructurado.

2. **http**
   - Permite realizar solicitudes HTTP para consumir la API.

   **Beneficio:**
   - Es ligera y fácil de usar, perfecta para integraciones simples y directas con APIs REST.

---

