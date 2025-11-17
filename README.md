# Nariño Travel & Food

<!--
Este archivo README contiene la documentación principal del proyecto.
Se han agregado comentarios y secciones explicativas para principiantes.
-->

Aplicación web y móvil para descubrir destinos turísticos y experiencias gastronómicas en el departamento de Nariño, Colombia.

## 🎉 Estado del Proyecto
- **Fecha de finalización:** Noviembre de 2025
- **Estado:** ✅ Completo y funcional (en proceso de depuracion)
- **URL pública:** [https://narinotravelfood-eff35.web.app/](https://narinotravelfood-eff35.web.app/)
- **Desarrollo local:** http://localhost:8080

## 🚀 Características principales
- Visualización de destinos turísticos y restaurantes
- Sistema de favoritos y reseñas
- Autenticación de usuarios
- Soporte multilenguaje (español/inglés)
- Integración con mapas y multimedia
- Despliegue en web y dispositivos móviles

## 🏆 Logros principales
- Problema OAuth resuelto completamente
- Autenticación Google funcionando
- App desplegada en Firebase Hosting
- Scripts automatizados creados
- Documentación completa generada
- Proyecto guardado localmente

## 🛠️ Tecnologías utilizadas
- Flutter 3.x (Desarrollo móvil/web)
- Firebase Auth + Hosting (Backend)
- Google Sign-In (Autenticación)
- Material 3 (Diseño UI)
- Dart (Lenguaje principal)
- GitHub para control de versiones

## 🌟 Funcionalidades implementadas
- Autenticación Google completa
- Interfaz Material 3 moderna
- Multi-plataforma (Web, Android, iOS)
- Hosting en vivo (Firebase)
- Scripts automatizados
- Optimización de rendimiento

## 📦 Instalación
1. Clona el repositorio:
   ```bash
   git clone https://github.com/NDavidCT/narino-travel-food.git
   ```
2. Ingresa a la carpeta del proyecto:
   ```bash
   cd narino-travel-food
   ```
3. Instala dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la app:
   ```bash
   flutter run
   ```

## 📷 Capturas de pantalla
Agrega aquí imágenes de la app funcionando (opcional).

## 🤝 Contribuciones
¿Quieres aportar? Haz un fork, crea una rama y envía tu pull request.

## 📄 Licencia
Este proyecto es educativo y abierto para la comunidad, especialmente mis estudiantes graduados promoción 2025.

---
Desarrollado por el Ing. de Sistemas David Coral Toro y estudiantes de 3 Colegios Ipiales (IE Microempresarial los Andes), Pupiales (IE DE COMERCIO) y Potosí (IE Agropecuaria Luis Antonio Montero).

🙏 **Agradecimientos:**
Gracias a Dios por permitir completar exitosamente este proyecto de turismo para el departamento de Nariño.

---

## 📚 Explicación de archivos clave y configuración

### pubspec.yaml
Archivo principal de configuración de Flutter. Aquí defines:
- El nombre y descripción del proyecto.
- Las dependencias (paquetes) que usa la app, como Firebase, mapas, iconos, etc.
- Los assets (imágenes, recursos) que se incluyen.
- Opciones de internacionalización y generación de archivos de traducción.

### analysis_options.yaml
Define las reglas de estilo y buenas prácticas para el código Dart/Flutter. Ayuda a mantener el código limpio y profesional. Puedes personalizar las reglas según tus necesidades.

### .gitignore
Indica qué archivos y carpetas NO deben subirse al repositorio de GitHub. Así evitas compartir archivos temporales, de configuración local o builds generados automáticamente.

### firebase.json
Archivo de configuración para el despliegue en Firebase Hosting. Aquí se define:
- El directorio público que se sube (`build/web`).
- Qué archivos ignorar durante el despliegue.
- Cómo redirigir todas las rutas al archivo principal `index.html`.
- Los identificadores de proyecto y app para conectar Flutter con Firebase.

### Estructura de carpetas
- `lib/`: Código fuente principal de la app (Dart/Flutter).
- `assets/`: Imágenes y recursos multimedia.
- `android/` y `ios/`: Archivos de configuración para despliegue móvil.
- `web/`: Archivos para la versión web.
- `test/`: Pruebas automáticas.
- `scripts/`: Scripts de automatización (si los agregas).

### ¿Cómo funcionan las traducciones?
- Los archivos en `lib/l10n/` contienen los textos en español e inglés.
- El sistema de internacionalización permite cambiar el idioma desde la app.

### ¿Cómo se conectan Firebase y Google?
- Las dependencias en `pubspec.yaml` y la configuración en `firebase.json` permiten autenticar usuarios, guardar datos y desplegar la app en la nube.
- El archivo `lib/services/google_sign_in_service.dart` gestiona el inicio de sesión con Google.

### ¿Para qué sirven los scripts y archivos de configuración?
- Los scripts `.bat` y `.ps1` automatizan tareas como el despliegue, la restauración o la optimización del proyecto.
- Los archivos de configuración ayudan a mantener el proyecto ordenado y fácil de trabajar en equipo.

---

## 📝 Recomendaciones para aprendices
- Lee los comentarios en cada archivo para entender su función.
- Consulta la documentación oficial de Flutter y Firebase si tienes dudas.
- No dudes en experimentar y modificar el código para aprender más.

---
