[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

> Nota: Este repositorio ha sido migrado. El desarrollo activo continúa en https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

Un repositorio que promueve la pereza estratégica para una vida simplificada y productiva, que abarca agentes de IA, aprendizaje de idiomas y vlogs con consejos prácticos y casos de uso reales.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Tabla de contenidos

- [Visión general](#vision-general)
- [Proyectos](#proyectos)
- [Herramientas de automatización](#herramientas-de-automatizacion)
- [Estructura de carpetas](#estructura-de-carpetas)
- [Introducción](#introduccion)
- [La teoría del lazying](#la-teoria-del-lazying)
- [Consejos y trucos prácticos](#consejos-y-trucos-practicos)
- [Casos de uso](#casos-de-uso)
- [Agentes de IA y automatización](#agentes-de-ia-y-automatizacion)
- [Aprendizaje de idiomas y vlogs](#aprendizaje-de-idiomas-y-vlogs)
- [Contribuciones de la comunidad](#contribuciones-de-la-comunidad)
- [Prerrequisitos](#prerrequisitos)
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
- [Contacto](#contacto)

## Visión general

`the-art-of-lazying-legacy` es un repositorio paraguas curado alrededor de la pereza estratégica:

- Contenido conceptual sobre cómo aplicar la filosofía de "lazying" al trabajo y a la vida.
- Artefactos de código prácticos, incluido aprendizaje de idiomas con e-ink + GPT (`code/EinkWordsGPT`).
- Scripts utilitarios para flujos más seguros (`scripts/lazy-care/SafeShell`).
- Herramientas y fragmentos de automatización para vlogs (`vlogs/`).
- Recursos de demostración y ejemplos (`demos/`, `examples/`, `figs/`).

| Snapshot | Valor |
|---|---|
| Rol del repositorio | Archivo legado + mapa de ideas |
| Desarrollo activo | https://github.com/lachlanchen/the-art-of-lazying |
| Archivos README multilingües | `README.md`, `README_CN.md`, `README_EN.md` |
| Directorio i18n | `i18n/` (presente) |

Este repositorio sigue siendo útil como archivo legado y mapa de ideas, mientras que el desarrollo activo se ha movido al repositorio migrado enlazado arriba.

## Proyectos

### 🤖 Herramientas creativas impulsadas por IA

| Project | Description | Demo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | E-ink display with GPT-powered word learning | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Words origin analysis and presenting in graph. | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Tools for efficient language learning with minimal effort | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Video & image captioning with OpenAI CLIP embeddings + GPT decoder | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Video captioning tool: extract key-frames with Katna/OpenCV & generate captions with a ViT+GPT-2 model | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Multilingual transcription pipeline with fine-grained language detection | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Breaking language barriers for global creative exchange | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Automatic metadata generation for videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | AI-powered automatic video editing tool with transcription, auto-subtitle, highlighting, and metadata generation | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Streamlining content publishing workflows | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Automated system for monitoring, processing, and publishing video content to multiple platforms | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Advanced techniques for effectively using AI assistants | |

## Herramientas de automatización

El repositorio incluye utilidades de automatización local ejecutables directamente:

| Path | Purpose |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Continuous e-ink word-card rendering loop (default refresh every 300s). |
| `code/EinkWordsGPT/words_update.py` | Batch and targeted word detail refresh against OpenAI-backed logic. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Waveshare 7.3" e-paper hardware test. |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | `saferm`, `unrm`, and `removeitanyway` shell functions. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Domain-to-IP resolution + deduplicated output. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Merge `.py` files by subdirectory into `.txt` files. |

## Estructura de carpetas

### Estructura actual del repositorio (precisa)

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

### Estructura conceptual original (preservada)

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

> Nota: El mapa conceptual anterior se conserva intencionalmente de versiones anteriores del README. El bloque "Estructura actual del repositorio" refleja el árbol concreto en este repositorio legado.

## Introducción

The Art of Lazying presenta la pereza estratégica como una forma de optimizar el uso de energía y enfocarse en lo que realmente importa. Este repositorio explora cómo la pereza intencional puede conducir a mayor productividad, creatividad y bienestar.

## La teoría del lazying

Una introducción integral a los principios de la pereza estratégica, centrada en cómo maximizar la productividad y el bienestar priorizando, delegando y automatizando tareas.

El principio clave es aplicar la regla 80/20 de Pareto a la vida diaria: identificar el 20% de actividades que producen el 80% de los resultados deseados.

## Consejos y trucos prácticos

Una colección de recomendaciones accionables para aplicar principios de pereza al trabajo, las relaciones y el autocuidado:

- Automatizar tareas repetitivas
- Usar la técnica Pomodoro para la gestión del tiempo
- Crear sistemas que reduzcan la fatiga de decisión
- Aprovechar herramientas de IA para asistencia

## Casos de uso

Ejemplos reales que demuestran cómo los principios de lazying resuelven problemas y mejoran la eficiencia:

- Cómo los emprendedores usan delegación y automatización para enfocarse en el crecimiento del negocio
- Cómo el personal académico optimiza los flujos de investigación
- Cómo los creadores de contenido optimizan su proceso de producción

## Agentes de IA y automatización

Explora el desarrollo de agentes de IA y herramientas de automatización que simplifican tareas:

- Uso de ChatGPT como asistente personal
- Construcción de flujos de automatización personalizados
- Creación de pantallas e-ink para aprendizaje pasivo

## Aprendizaje de idiomas y vlogs

Recursos y técnicas para aprender idiomas de forma eficiente, además de vlogs que documentan el recorrido de lazying:

- Crear aprendizaje de idiomas personalizado con repetición espaciada
- Implementar técnicas de aprendizaje inmersivo
- Construir proyectos que fomenten el aprendizaje pasivo

## Contribuciones de la comunidad

Comparte tus experiencias, consejos e ideas sobre pereza estratégica:

- Foro para intercambiar hacks de productividad
- Herramientas y plantillas para rutinas diarias
- Proyectos colaborativos para eficiencia con menor esfuerzo

## Prerrequisitos

El repositorio contiene varios scripts independientes, por lo que los prerrequisitos varían según el módulo.

Base común:

- Python 3.9+
- `pip`
- Git

Señales específicas por proyecto a partir de los archivos fuente:

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (para flujos con hardware e-paper)
- `sqlite3` (biblioteca estándar)

Requisitos de hardware para ejecutar `EinkWordsGPT` completo:

- Raspberry Pi (la documentación del proyecto menciona Raspberry Pi 5)
- Panel e-ink Waveshare de 7 colores y 7.3 pulgadas

## Instalación

Como no hay un manifiesto de dependencias en la raíz, instala manualmente las dependencias del módulo que quieras ejecutar.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Dependencia opcional/de hardware:

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

### 4) Resolver dominios relacionados con ChatGPT y salida de IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Combinar archivos Python por directorio para paquetes de texto aptos para IA

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Usar un flujo más seguro para borrar archivos

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Configuración

### Credenciales de OpenAI

`EinkWordsGPT` y los scripts de actualización usan `OpenAI()` del SDK oficial y esperan credenciales configuradas en tu entorno.

Suposición (recomendada):

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Ubicación de la base de datos

`code/EinkWordsGPT/words_gpt.py` y `words_update.py` usan:

- `db_path = 'words_phonetics.db'`

Ejecuta los scripts desde `code/EinkWordsGPT` o actualiza rutas si los lanzas desde otra ubicación.

### Raíz de la papelera de SafeShell

`saferm`/`unrm`/`removeitanyway` usan actualmente una ruta base fija:

- `/mnt/disk/BIN/ROOT`

Asegúrate de que esta ruta exista y tenga permisos de escritura antes de depender de `saferm`.

### Rutas de Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` tiene actualmente rutas codificadas:

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Edita estas constantes para que coincidan con tu proyecto local.

## Ejemplos

### Ejemplo: ciclo de tarjetas de aprendizaje en e-ink

- El script elige (o obtiene) detalles de palabras.
- La tarjeta renderiza fonética, segmentación silábica y pistas de sinónimos en japonés.
- La pantalla se actualiza cada 5 minutos (`time.sleep(300)`).

### Ejemplo: flujo de borrado seguro

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Ejemplo: archivo de salida dominio/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Notas de desarrollo

- Este es un repositorio legado; el desarrollo activo está en: https://github.com/lachlanchen/the-art-of-lazying
- El contenido de nivel superior es curatorial y enlaza a muchos repositorios externos.
- `i18n/` existe pero actualmente está vacío; los README de idiomas viven actualmente en el nivel superior.
- No hay `requirements.txt` ni `pyproject.toml` en la raíz.

Nota de compatibilidad preservada:

- Documentos anteriores en subcarpetas pueden mencionar scripts (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) que ahora están consolidados en `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Solución de problemas

- `ModuleNotFoundError`: instala los paquetes Python faltantes listados en [Prerrequisitos](#prerrequisitos).
- Errores de autenticación `openai`: confirma que `OPENAI_API_KEY` esté exportada en tu shell.
- Problemas de ejecución con Waveshare: verifica la configuración de SPI/dispositivo e instala dependencias del proveedor en la Pi.
- `saferm` parece no hacer nada: verifica que `/mnt/disk/BIN/ROOT` exista y tenga permisos de escritura.
- `repo2text` no genera archivos: asegúrate de que `source_directory` apunte a una carpeta existente con archivos `.py`.
- Anomalías de dominio en `chatgpt-traffic`: revisa y limpia la lista `domains` del script antes de usar en producción.

## Hoja de ruta

- Mantener este repositorio como un archivo legado estable con referencias claras a proyectos activos.
- Mejorar los manifiestos de dependencias para cada submódulo ejecutable.
- Añadir en futuras revisiones un diseño i18n consistente bajo `/i18n`.
- Ampliar ejemplos prácticos y guías de configuración reproducibles para flujos con y sin hardware.

## Contribuir

Las contribuciones son bienvenidas.

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

También puedes contribuir:

- Sugiriendo mejoras a flujos de pereza estratégica.
- Reportando problemas en scripts o documentación.
- Mejorando la reproducibilidad de configuración en rutas de hardware/software.

## Licencia

Este repositorio está licenciado bajo GNU General Public License v3.0. Consulta [LICENSE](../LICENSE).

## Agradecimientos

Gracias especiales a quienes contribuyen, al equipo de OpenAI y a las comunidades de Raspberry Pi / makers que apoyan la experimentación alrededor de sistemas de aprendizaje de baja fricción.

## Contacto

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art
