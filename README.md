# Recipes App

Una aplicación de recetas que permite buscar y guardar tus recetas favoritas. Desarrollada con Flutter y siguiendo principios de Clean Architecture.

## Características

- Búsqueda de recetas por nombre
- Carga infinita de recetas organizadas alfabéticamente
- Sistema de favoritos para guardar tus recetas preferidas (Sin persistencia)
- Diseño siguiendo Clean Architecture

## Requisitos Previos

- Flutter SDK (versión >=3.2.3)
- Dart SDK (versión >=3.2.3)
- Android Studio / VS Code con extensiones de Flutter
- Git

## Instalación

1. Clona el repositorio:
```bash
git clone https://github.com/yourusername/recipes_app.git
cd recipes_app
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Genera los archivos necesarios:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Ejecuta la aplicación:
```bash
flutter run
```

## Estructura del Proyecto

```
lib/
├── core/
│   ├── domain/
│   │   ├── extensions/
│   │   └── facades/
│   └── presentation/
│       ├── resources/
│       └── ui/
└── features/
    ├── home/
    │   └── presentation/
    └── recipes/
        ├── data/
        │   ├── dtos/
        │   ├── mappers/
        │   ├── repositories/
        │   └── sources/
        ├── domain/
        │   ├── models/
        │   ├── repositories/
        │   └── sources/
        └── presentation/
            ├── pages/
            └── widgets/
```

## Tecnologías Utilizadas

- Flutter
- BLoC para manejo de estado
- Freezed para inmutabilidad
- Clean Architecture
- TheMealDB API

## Demo

![Demo de la app](demo.gif)

