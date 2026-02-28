[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Nota: Este repositorio se ha migrado. El desarrollo activo continúa en https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)
[![GitHub last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying-legacy?label=last%20commit)](https://github.com/lachlanchen/the-art-of-lazying-legacy/commits/main)
[![Open Issues](https://img.shields.io/github/issues/lachlanchen/the-art-of-lazying-legacy?label=issues)](https://github.com/lachlanchen/the-art-of-lazying-legacy/issues)
[![Maintainer](https://img.shields.io/badge/maintainer-lachlanchen-2f80ed)](https://github.com/lachlanchen)

Un repositorio que promueve la pereza estratégica para una vida simplificada y productiva, que abarca agentes de IA, aprendizaje de idiomas y vlogs con consejos prácticos y casos de uso reales.

![Demo de EinkWordsGPT](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Tabla de contenidos

- [Resumen](#resumen)
- [Proyectos](#proyectos)
- [Herramientas de automatización](#herramientas-de-automatizacion)
- [Estructura de carpetas](#estructura-de-carpetas)
- [Introducción](#introduccion)
- [La teoría de la pereza](#la-teoria-de-la-pereza)
- [Consejos y trucos prácticos](#consejos-y-trucos-practicos)
- [Casos de uso](#casos-de-uso)
- [Agentes de IA y automatización](#agentes-de-ia-y-automatizacion)
- [Aprendizaje de idiomas y vlogs](#aprendizaje-de-idiomas-y-vlogs)
- [Contribuciones de la comunidad](#contribuciones-de-la-comunidad)
- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalacion)
- [Uso](#uso)
- [Configuración](#configuracion)
- [Ejemplos](#ejemplos)
- [Notas de desarrollo](#notas-de-desarrollo)
- [Solución de problemas](#solucion-de-problemas)
- [Hoja de ruta](#hoja-de-ruta)
- [Contribuir](#contribuir)
- [Licencia](#licencia)
- [Agradecimientos](#agradecimientos)
- [Conectar](#conectar)

## Enlaces rápidos

| Necesidad | Empieza aquí |
|---|---|
| Ver el mapa de contenido principal | [Resumen](#resumen) |
| Instalar dependencias | [Requisitos previos](#requisitos-previos) |
| Ejecutar ejemplos | [Uso](#uso) |
| Solucionar problemas comunes | [Solución de problemas](#solucion-de-problemas) |
| Involucrarte | [Contribuir](#contribuir) |

## Resumen

`the-art-of-lazying-legacy` es un repositorio curado en torno a la pereza estratégica:

- Contenido conceptual sobre la aplicación de la filosofía de la pereza a la vida y al trabajo.
- Artefactos prácticos de código, incluido aprendizaje de idiomas con e-ink + GPT (`code/EinkWordsGPT`).
- Scripts utilitarios para flujos de trabajo más seguros (`scripts/lazy-care/SafeShell`).
- Herramientas de vlogs y fragmentos de automatización (`vlogs/`).
- Recursos y demos (`demos/`, `examples/`, `figs/`).

| Snapshot | Valor |
|---|---|
| Rol del repositorio | Archivo legado + mapa de ideas |
| Desarrollo activo | https://github.com/lachlanchen/the-art-of-lazying |
| Archivos README multilingües | `README.md`, `README_CN.md`, `README_EN.md` |
| Directorio i18n | `i18n/` (presente) |
| Aprendizaje de idiomas | Repetición espaciada + flujos de trabajo con GPT |
| Enfoque de automatización | Scripts, subtitulado, publicación y flujos de hardware |

Este repositorio sigue siendo útil como archivo legado y mapa de ideas, mientras que el desarrollo activo se ha trasladado al repositorio migrado enlazado arriba.

---

## Proyectos

### 🤖 Herramientas creativas impulsadas por IA

| Proyecto | Descripción | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Pantalla de tinta electrónica con aprendizaje de vocabulario potenciado por GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Análisis del origen de palabras y presentación en grafo. | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Herramientas para aprender idiomas con poco esfuerzo | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Subtítulos de vídeo e imagen con embeddings de OpenAI CLIP + decodificador GPT | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Herramienta de subtitulado de vídeo: extrae fotogramas clave con Katna/OpenCV y genera subtítulos con un modelo ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Canalización de transcripción multilingüe con detección de idioma detallada | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Romper barreras lingüísticas para el intercambio creativo global | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Generación automática de metadatos para vídeos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Herramienta de edición automática de vídeo impulsada por IA con transcripción, subtítulos automáticos, resaltado y generación de metadatos | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Simplificación de flujos de publicación de contenido | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Sistema automatizado para supervisar, procesar y publicar contenidos de vídeo en múltiples plataformas | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Técnicas avanzadas para usar asistentes de IA de forma eficaz | |

## Herramientas de automatización

El repositorio incluye utilidades de automatización local de ejecución directa:

| Ruta | Propósito |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Bucle continuo de renderizado de tarjetas de palabras en e-ink (actualización predeterminada cada 300 s). |
| `code/EinkWordsGPT/words_update.py` | Actualización por lotes y por objetivo de detalles de palabras con lógica basada en OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Prueba de hardware de e-paper de 7.3 pulgadas de Waveshare. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Funciones de shell `saferm`, `unrm` y `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Resolución dominio-IP + salida deduplicada. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Fusiona archivos `.py` por subdirectorio en archivos `.txt`. |

## Estructura de carpetas

### Estructura actual del repositorio (exacta)

```text
the-art-of-lazying-legacy/
├── README.md
├── README_EN.md
├── README_CN.md
├── LICENSE
├── books/
├── code/
│   └── EinkWordsGPT/
├── demos/
├── examples/
├── figs/
├── i18n/                      # currently present
├── scripts/
│   └── lazy-care/
└── vlogs/
```

### Estructura conceptual original (conservada)

```text
the-art-of-lazying/
│
├───code/
│ ├───ai-agents/
│ ├───automation/
│ └───language-learning/
│
├───book/
│ ├───manuscript/
│ └───resources/
│
├───examples/
│ ├───practical-tips/
│ ├───use-cases/
│ └───community-contributions/
│
└───vlogs/
  ├───language-learning/
  └───lazy-lifestyle/
```

> Nota: El mapa conceptual anterior se conserva deliberadamente de versiones anteriores del README. El bloque "Estructura actual del repositorio" refleja el árbol real de este repositorio legado.

## Introducción

El arte de la pereza presenta la pereza estratégica como una forma de optimizar la energía y centrarse en lo que realmente importa. Este repositorio explora cómo una pereza intencional puede conducir a una mayor productividad, creatividad y bienestar.

## La teoría de la pereza

Una introducción completa a los principios de la pereza estratégica, centrada en cómo maximizar la productividad y el bienestar priorizando, delegando y automatizando tareas.

El principio clave es aplicar la regla 80/20 de Pareto a la vida diaria: identificar el 20% de actividades que producen el 80% de los resultados deseados.

## Consejos y trucos prácticos

Una colección de consejos prácticos para aplicar principios de pereza en el trabajo, relaciones y autocuidado:

- Automatizar tareas repetitivas
- Usar la técnica Pomodoro para la gestión del tiempo
- Crear sistemas que reduzcan la fatiga de decisiones
- Aprovechar herramientas de IA como ayuda

## Casos de uso

Ejemplos del mundo real que muestran cómo los principios de pereza resuelven problemas y mejoran la eficiencia:

- Cómo emprendedores usan la delegación y automatización para centrarse en el crecimiento del negocio
- Cómo investigadores agilizan flujos de trabajo de investigación
- Cómo creadores de contenido optimizan su proceso de producción

## Agentes de IA y automatización

Explora el desarrollo de agentes de IA y herramientas de automatización que simplifican tareas:

- Usar ChatGPT como asistente personal
- Construir flujos de automatización personalizados
- Crear pantallas de tinta electrónica para aprendizaje pasivo

## Aprendizaje de idiomas y vlogs

Recursos y técnicas para un aprendizaje eficiente de idiomas, además de vlogs que documentan el recorrido de la pereza:

- Crear aprendizaje personalizado de idiomas con repetición espaciada
- Implementar técnicas de aprendizaje inmersivo
- Construir proyectos que fomenten el aprendizaje pasivo

## Contribuciones de la comunidad

Comparte tus propias experiencias, consejos e ideas sobre la pereza estratégica:

- Foro para intercambiar trucos de productividad
- Herramientas y plantillas para rutinas diarias
- Proyectos colaborativos para una eficiencia con mínimo esfuerzo

## Requisitos previos

El repositorio contiene múltiples scripts independientes, por lo que los requisitos previos varían por módulo.

Base común:

- Python 3.9+
- `pip`
- Git

Señales específicas por proyecto desde archivos fuente:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (para flujos de hardware de pantalla e-paper)
- `sqlite3` (librería estándar)

Requisitos de hardware para ejecución completa de `EinkWordsGPT`:

- Raspberry Pi (la documentación del proyecto menciona Raspberry Pi 5)
- Panel Waveshare de tinta electrónica de 7 colores y 7.3 pulgadas

## Instalación

Como no existe un manifiesto raíz de dependencias, instala manualmente las dependencias del módulo que quieres ejecutar.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Dependencia opcional/hardware:

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

Configuración de SafeShell:

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Uso

### 1) Ejecutar el bucle de visualización de EinkWordsGPT

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Revisar/actualizar detalles de palabras

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Probar el panel Waveshare de 7.3 pulgadas

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Resolver dominios relacionados con ChatGPT y salida IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Fusionar archivos Python por directorio para paquetes de texto para IA

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Usar un flujo de eliminación de archivos más seguro

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Configuración

### Credenciales de OpenAI

`EinkWordsGPT` y los scripts de actualización usan `OpenAI()` desde el SDK oficial y esperan credenciales configuradas en tu entorno.

Suposición (recomendada):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Ubicación de la base de datos

`code/EinkWordsGPT/words_gpt.py` y `words_update.py` usan:

- `db_path = 'words_phonetics.db'`

Ejecuta los scripts desde `code/EinkWordsGPT` o actualiza rutas si se lanzan desde otro lugar.

### Raíz de la papelera de SafeShell

`saferm`/`unrm`/`removeitanyway` usan actualmente una ruta base fija:

- `/mnt/disk/BIN/ROOT`

Asegúrate de que esta ruta exista y tenga permisos de escritura antes de depender de `saferm`.

### Rutas de Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` tiene rutas codificadas:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Edita estas constantes para que coincidan con tu proyecto local.

## Ejemplos

### Ejemplo: Ciclo de tarjetas de aprendizaje en e-ink

- El script elige (o recupera) detalles de palabras.
- La tarjeta de aprendizaje renderiza fonética, segmentación silábica y pistas de sinónimos en japonés.
- La pantalla se actualiza cada 5 minutos (`time.sleep(300)`).

### Ejemplo: Flujo de eliminación segura

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Ejemplo: Archivo de salida de dominio/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Notas de desarrollo

- Este es un repositorio legado; el desarrollo activo está en: https://github.com/lachlanchen/the-art-of-lazying
- El contenido de nivel superior es curatorial y enlaza a muchos repositorios externos.
- `i18n/` existe pero actualmente está vacío; los README de idiomas viven actualmente en el nivel superior.
- No existe un `requirements.txt` ni un `pyproject.toml` en la raíz.

Nota de compatibilidad preservada:

- Documentos anteriores en subcarpetas pueden mencionar scripts (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) que ahora están consolidados en `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Solución de problemas

- `ModuleNotFoundError`: Instala los paquetes de Python faltantes listados en [Requisitos previos](#requisitos-previos).
- Errores de autenticación de `openai`: confirma que `OPENAI_API_KEY` esté exportada en tu shell.
- Problemas de ejecución de Waveshare: verifica la configuración SPI/dispositivo e instala dependencias del proveedor en la Pi.
- `saferm` parece no hacer nada: verifica que `/mnt/disk/BIN/ROOT` exista y tenga permisos de escritura.
- `repo2text` no genera archivos: asegúrate de que `source_directory` apunte a una carpeta existente con archivos `.py`.
- Anomalías de dominio en `chatgpt-traffic`: revisa y limpia la lista `domains` del script antes de su uso en producción.

## Hoja de ruta

- Mantener este repositorio como un archivo legado estable con referencias claras a proyectos activos.
- Mejorar manifiestos de dependencias para cada submódulo ejecutable.
- Añadir un diseño i18n consistente en futuras revisiones bajo `/i18n`.
- Ampliar ejemplos prácticos y guías de configuración reproducibles para flujos con y sin hardware.

## Contribuir

Las contribuciones son bienvenidas.

1. Haz un fork del proyecto.
2. Crea tu rama de características (`git checkout -b feature/AmazingFeature`).
3. Haz commit de tus cambios (`git commit -m 'Add some AmazingFeature'`).
4. Haz push a la rama (`git push origin feature/AmazingFeature`).
5. Abre una Pull Request.

También puedes contribuir:

- Sugiriendo mejoras a flujos de pereza estratégica.
- Informando de problemas en scripts o documentación.
- Mejorando la reproducibilidad de configuración en rutas de hardware/software.

## Licencia

Este repositorio está licenciado bajo la Licencia Pública General GNU v3.0. Consulta [LICENSE](../LICENSE).

## Agradecimientos

Agradecimiento especial a los contribuyentes, al equipo de OpenAI y a las comunidades de Raspberry Pi / makers que apoyan la experimentación en torno a sistemas de aprendizaje de baja fricción.

## Conectar

- Sitio web: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
