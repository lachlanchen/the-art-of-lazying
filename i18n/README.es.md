[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

# El arte de la pereza estratégica

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](../LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

Un repositorio centrado en la pereza estratégica para una vida más simple y de mayor rendimiento, que abarca agentes de IA, aprendizaje de idiomas, automatización práctica y flujos de trabajo reales impulsados por vlogs.

| Enfoque | Lo que contiene este README |
|---|---|
| 🤖 Automatización | Herramientas, scripts y flujos de trabajo prácticos que puedes ejecutar localmente |
| 🧠 Aprendizaje | Proyectos y ejemplos con enfoque de idioma para hábitos de estudio eficientes |
| 📚 Compartir | Documentación multilingüe, enlaces de proyectos y pautas de contribución |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Tabla de contenidos

- [Resumen](#resumen)
- [Proyectos](#proyectos)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Características](#características)
- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Configuración](#configuración)
- [Ejemplos](#ejemplos)
- [Notas de desarrollo](#notas-de-desarrollo)
- [Solución de problemas](#solución-de-problemas)
- [Hoja de ruta](#hoja-de-ruta)
- [Introducción](#introducción)
- [La teoría de la pereza estratégica](#la-teoría-de-la-pereza-estratégica)
- [Consejos y trucos prácticos](#consejos-y-trucos-prácticos)
- [Casos de uso](#casos-de-uso)
- [Agentes de IA y automatización](#agentes-de-ia-y-automatización)
- [Aprendizaje de idiomas y vlogs](#aprendizaje-de-idiomas-y-vlogs)
- [Contribuciones de la comunidad](#contribuciones-de-la-comunidad)
- [❤️ Support](#-support)
- [Conectar](#conectar)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

## Resumen

`the-art-of-lazying` es un repositorio central para la pereza estratégica práctica: automatizar trabajo repetitivo, mejorar flujos de aprendizaje de idiomas y documentar experimentos del mundo real mediante scripts y vlogs.

| A primera vista | Detalles |
|---|---|
| 🎯 Tema central | Pereza estratégica para productividad, aprendizaje y creación de contenido |
| 🧩 Estilo del repositorio | Híbrido de herramientas locales + proyectos externos curados |
| 🛠️ Destacados locales | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Documentación | README principal + variantes multilingües en `i18n/` |

Este repositorio contiene ambos:
- Enlaces curados a proyectos externos relacionados.
- Herramientas y código locales, especialmente:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + pantalla de aprendizaje de vocabulario con OpenAI).
  - `scripts/lazy-care/SafeShell` (funciones de shell para borrar/restaurar de forma segura).
  - `vlogs/chatgpt-traffic` y `vlogs/repo2text` (pequeñas utilidades en Python).

## Proyectos

### 🚀 Herramientas creativas impulsadas por IA

| Proyecto | Descripción | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Pantalla e-ink con aprendizaje de vocabulario con GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Análisis del origen de palabras y presentación en gráfico | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Herramientas para aprender idiomas con poco esfuerzo | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Subtitulación de video e imágenes con incrustaciones OpenAI CLIP + decodificador GPT | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Herramienta de subtitulado de video: extrae fotogramas clave con Katna/OpenCV y genera subtítulos con un modelo ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcripción multilingüe con detección de idioma granular | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Romper barreras de idioma para el intercambio creativo global | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Generación automática de metadatos para vídeos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Herramienta de edición de vídeo automática con transcripción, subtitulado automático, resaltado y generación de metadatos | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Optimización de flujos de publicación de contenido | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Sistema automatizado para monitorear, procesar y publicar contenidos de vídeo en múltiples plataformas | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Técnicas avanzadas para usar asistentes de IA con eficacia | |

### ⚙️ Herramientas de automatización (locales en este repositorio)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: borrado seguro en shell (`saferm`), restauración (`unrm`) y borrado permanente explícito (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: resolutor dominio a IP y generador de salida deduplicada.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: combina archivos Python por directorio en paquetes de texto para análisis asistido por IA.

## Estructura del repositorio

```text
the-art-of-lazying/
├── README.md
├── README_EN.md
├── README_CN.md
├── LICENSE
├── .github/
│   └── FUNDING.yml
├── i18n/
│   ├── README.ar.md
│   ├── README.es.md
│   ├── README.fr.md
│   ├── README.ja.md
│   ├── README.ko.md
│   ├── README.vi.md
│   ├── README.zh-Hans.md
│   └── README.zh-Hant.md
├── code/
│   └── EinkWordsGPT/
│       ├── README.md
│       ├── README_CN.md
│       ├── words_gpt.py
│       ├── words_data.py
│       ├── words_update.py
│       ├── epd_7in3f_test.py
│       ├── words_phonetics.db
│       ├── data/
│       ├── font/
│       └── pic/
├── scripts/
│   └── lazy-care/
│       ├── README.md
│       └── SafeShell/
│           ├── README.md
│           └── safeshell_functions.sh
├── examples/
│   └── lazy-learning/BuildChachaGPTWithChatGPT/
├── books/
├── demos/
├── figs/
└── vlogs/
    ├── chatgpt-traffic/
    ├── repo2text/
    └── google-framework/
```

Nota: Las variantes de README anteriores incluían diagramas de carpetas genéricos con rutas abstractas (por ejemplo `book/`, `code/ai-agents/`) que no coinciden exactamente con el árbol real del repositorio actual. La estructura anterior refleja los archivos actuales.

## Características

- Marco de pereza estratégica para productividad, aprendizaje y flujos de contenido.
- Portafolio curado de proyectos de IA que cubre transcripción, subtitulado, traducción y automatización de publicación.
- Aprendizaje de idiomas integrado con hardware y selección de vocabulario asistida por GPT (`EinkWordsGPT`).
- Herramientas prácticas de seguridad en shell para eliminar y restaurar archivos.
- Utilidades basadas en scripts para comprobaciones DNS/tráfico de dominio y conversión de repositorio a texto.
- Soporte de documentación multilingüe vía `i18n/`.

## Requisitos previos

General:
- Git
- Python 3.9+ recomendado

Para `code/EinkWordsGPT`:
- Raspberry Pi (la documentación del proyecto menciona Raspberry Pi 5)
- Pantalla e-ink Waveshare de 7,3 pulgadas y 7 colores con soporte de controlador Python (`waveshare_epd`)
- Paquetes de Python usados en el código: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (se usa `sqlite3` de la biblioteca estándar de Python)
- Clave de API de OpenAI configurada en el entorno (el código inicializa `OpenAI()` directamente)

Para `vlogs/chatgpt-traffic`:
- `dnspython`

Para `scripts/lazy-care/SafeShell`:
- Shell Bash o Zsh con acceso a `realpath`, `mv` y `/bin/rm`

## Instalación

Clonar el repositorio:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Instalar dependencias comunes de Python (base recomendada para el repositorio):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Nota: `code/EinkWordsGPT/README.md` menciona `requirements.txt`, pero actualmente no existe `requirements.txt` en este repositorio. Instala paquetes manualmente como arriba.

## Uso

### 1) EinkWordsGPT (flujo local con hardware)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # prueba opcional de hardware/pantalla
python words_gpt.py        # ejecuta el bucle de pantalla (refresca aproximadamente cada 300s)
```

Script opcional de mantenimiento de base de datos:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (flujo de borrado más seguro)

Carga las funciones de shell:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # o ~/.zshrc
source ~/.bashrc                          # o source ~/.zshrc
```

Usa estos comandos:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Resolver de tráfico ChatGPT

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Conversor repositorio-a-texto

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Nota: `convert-repo-to-merged-text.py` usa rutas fijas actualmente (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Edita estas constantes antes de ejecutarlo con otro repositorio.

## Configuración

### Configuración de OpenAI (`code/EinkWordsGPT`)

El código crea el cliente con:

```python
client = OpenAI()
```

Por eso, configura tus credenciales de API con el enfoque estándar de variables de entorno de OpenAI antes de ejecutar los scripts.

### Ruta de base de datos (`code/EinkWordsGPT`)

Valor predeterminado en el código:

```python
db_path = 'words_phonetics.db'
```

Asegúrate de que `words_phonetics.db` exista en `code/EinkWordsGPT/` (actualmente se incluye en este repositorio).

### Ubicación de la papelera de SafeShell

`saferm`/`unrm`/`removeitanyway` usan una ruta base fija:

```bash
/mnt/disk/BIN/ROOT
```

Ajusta esta ruta en `scripts/lazy-care/SafeShell/safeshell_functions.sh` si tu entorno es distinto.

## Ejemplos

- Demos de tarjetas de palabras en e-ink en `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Notas/materiales de construcción para ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Notas de desarrollo

- Este es un repositorio tipo escaparate con múltiples proyectos y con código local junto a enlaces de proyectos externos.
- No existe en la raíz un gestor de paquetes o manifiesto de compilación (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` no están presentes).
- Varios README de subproyectos tienen formato de plantilla y pueden estar algo desactualizados respecto al diseño actual del repositorio; los comandos de este README están alineados con las rutas y scripts que sí existen.
- `README_EN.md` y `README_CN.md` siguen existiendo como variantes heredadas; `README.md` + `i18n/*` es la estructura multilingüe activa.

## Solución de problemas

- `ModuleNotFoundError` para paquetes de Python:
  - Reinstala dependencias con `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` en `EinkWordsGPT`:
  - Instala el controlador/biblioteca Python de e-paper de Waveshare en tu entorno Raspberry Pi.

- Errores de autenticación de OpenAI:
  - Verifica que tu clave de API de OpenAI esté configurada en variables de entorno antes de ejecutar `words_gpt.py` o `words_update.py`.

- `saferm`/`unrm` no se encuentran después de la configuración:
  - Comprueba que has cargado el archivo rc correcto de la shell y que añadiste `safeshell_functions.sh` correctamente.

- `unrm` no puede restaurar archivos:
  - Comprueba que la ruta de restauración coincida con la estructura de papelera espejo de SafeShell en `/mnt/disk/BIN/ROOT`.

- `repo2text` no genera salida:
  - Actualiza `source_directory` en `convert-repo-to-merged-text.py` a una carpeta existente.

## Hoja de ruta

- Expandir la paridad del README principal en todas las traducciones `i18n` (actualmente muchos resúmenes en varios idiomas).
- Añadir documentación de configuración según entorno para los controladores de e-ink de Waveshare.
- Añadir manifiestos reproducibles de dependencias para herramientas locales.
- Añadir scripts de validación y pruebas para utilidades críticas.
- Seguir consolidando enlaces de proyectos externos con demos locales más detallados.

## Introducción

The Art of Lazying presenta la pereza estratégica como una forma de optimizar el uso de energía y centrarse en lo que realmente importa. Este repositorio explora cómo la pereza intencional puede conducir a mayor productividad, creatividad y bienestar.

## La teoría de la pereza estratégica

Introducción completa a los principios de la pereza estratégica, centrada en cómo maximizar productividad y bienestar priorizando, delegando y automatizando tareas.

El principio clave es aplicar la regla 80/20 de Pareto a la vida diaria: identificar el 20% de actividades que generan el 80% de los resultados deseados.

## Consejos y trucos prácticos

Una colección de consejos prácticos para aplicar principios de pereza en el trabajo, las relaciones y el autocuidado:
- Automatizar tareas repetitivas
- Usar la técnica Pomodoro para la gestión del tiempo
- Crear sistemas que reduzcan la fatiga de decisión
- Aprovechar herramientas de IA como asistencia

## Casos de uso

Ejemplos reales que muestran cómo los principios de la pereza resuelven problemas y mejoran la eficiencia:
- Cómo emprendedores usan delegación y automatización para centrarse en el crecimiento del negocio
- Cómo académicos optimizan flujos de investigación
- Cómo creadores de contenido optimizan su proceso de producción

## Agentes de IA y automatización

Se exploran los agentes de IA y herramientas de automatización que simplifican tareas:
- Usar ChatGPT como asistente personal
- Construir flujos de automatización personalizados
- Crear pantallas e-ink para aprendizaje pasivo

## Aprendizaje de idiomas y vlogs

Recursos y técnicas para aprender idiomas de forma eficiente, además de vlogs que documentan el camino de la pereza:
- Crear aprendizaje de idiomas personalizado con repetición espaciada
- Aplicar técnicas de aprendizaje inmersivo
- Construir proyectos que promuevan el aprendizaje pasivo

## Contribuciones de la comunidad

Comparte tus propias experiencias, consejos e ideas sobre la pereza estratégica:
- Foro para intercambiar trucos de productividad
- Herramientas y plantillas para rutinas diarias
- Proyectos colaborativos para eficiencia perezosa

## Conectar

- Sitio web: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

## Contribuir

Las contribuciones son bienvenidas en código, documentación, ejemplos y traducciones.

1. Haz un fork del repositorio.
2. Crea una rama (`git checkout -b feature/your-feature`).
3. Haz cambios con mensajes de commit claros.
4. Abre un pull request describiendo motivación e impacto.

Si no sabes por dónde empezar:
- Mejora la documentación de configuración de una herramienta local.
- Añade pruebas o scripts de validación para utilidades existentes.
- Mejora la paridad o calidad de una variante `i18n/README.*.md`.

## Licencia

Este repositorio incluye el texto de la licencia GPLv3 en la raíz (`../LICENSE`) y en varias subcarpetas.

Nota: Algunos README de subproyectos mencionan MIT. Hasta que se clarifique cada subproyecto, trata el repositorio raíz como regido por GPLv3 y verifica por subproyecto si planeas redistribuir código de forma independiente.


## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |
