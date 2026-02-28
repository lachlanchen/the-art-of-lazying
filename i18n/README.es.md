[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

# The Art of Lazying

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](../LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

Un repositorio centrado en la pereza estratégica para lograr una vida más simple y de mayor apalancamiento, que abarca agentes de IA, aprendizaje de idiomas, automatización práctica y flujos de trabajo reales impulsados por vlogs.

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Tabla de contenido

- [Visión general](#visión-general)
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
- [La teoría del Lazying](#la-teoría-del-lazying)
- [Consejos y trucos prácticos](#consejos-y-trucos-prácticos)
- [Casos de uso](#casos-de-uso)
- [Agentes de IA y automatización](#agentes-de-ia-y-automatización)
- [Aprendizaje de idiomas y vlogs](#aprendizaje-de-idiomas-y-vlogs)
- [Contribuciones de la comunidad](#contribuciones-de-la-comunidad)
- [Contacto](#contacto)
- [Soporte / Donaciones](#soporte--donaciones)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

## Visión general

`the-art-of-lazying` es un repositorio central sobre pereza estratégica práctica: automatiza trabajo repetitivo, mejora flujos de aprendizaje de idiomas y documenta experimentos del mundo real mediante scripts y vlogs.

| Resumen | Detalles |
|---|---|
| 🎯 Tema principal | Pereza estratégica para productividad, aprendizaje y producción creativa |
| 🧩 Estilo del repositorio | Híbrido de herramientas locales + proyectos externos curados |
| 🛠️ Puntos destacados locales | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Documentación | README raíz + variantes multilingües en `i18n/` |

Este repositorio contiene ambos tipos de contenido:
- Enlaces curados a proyectos externos relacionados.
- Herramientas y código locales, especialmente:
  - `code/EinkWordsGPT` (Raspberry Pi + Waveshare e-ink + pantalla de aprendizaje de vocabulario con OpenAI).
  - `scripts/lazy-care/SafeShell` (funciones de shell para borrar/restaurar de forma segura).
  - `vlogs/chatgpt-traffic` y `vlogs/repo2text` (pequeñas utilidades en Python).

## Proyectos

### 🚀 Herramientas creativas impulsadas por IA

| Proyecto | Descripción | Demo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Pantalla e-ink con aprendizaje de vocabulario impulsado por GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Análisis del origen de palabras y presentación en grafo. | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Herramientas para aprender idiomas de forma eficiente con el mínimo esfuerzo | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Subtitulado de video e imágenes con embeddings de OpenAI CLIP + decodificador GPT | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Herramienta de subtitulado de video: extrae fotogramas clave con Katna/OpenCV y genera descripciones con un modelo ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcripción multilingüe con detección de idioma granular | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Romper barreras lingüísticas para un intercambio creativo global | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Generación automática de metadatos para videos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Herramienta de edición de video automática impulsada por IA con transcripción, subtitulado automático, resaltado y generación de metadatos | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Optimización de flujos de publicación de contenido | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Sistema automatizado para monitorear, procesar y publicar contenido de video en múltiples plataformas | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Técnicas avanzadas para usar asistentes de IA de forma efectiva | |

### ⚙️ Herramientas de automatización (locales en este repositorio)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: borrado más seguro en shell (`saferm`), restauración (`unrm`) y borrado permanente explícito (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: resolvedor dominio-a-IP y generador de salida deduplicada.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: fusiona archivos Python por directorio en paquetes de texto para análisis asistido por IA.

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

Nota: Diagramas de carpetas genéricos en versiones anteriores del README hacían referencia a rutas abstractas (por ejemplo, `book/`, `code/ai-agents/`) que no coinciden exactamente con el árbol actual del repositorio. La estructura de arriba refleja los archivos actuales.

## Características

- Marco de pereza estratégica para productividad, aprendizaje y flujos de contenido.
- Portafolio curado de proyectos de IA que cubre transcripción, subtitulado, traducción y automatización de publicación.
- Aprendizaje de idiomas integrado con hardware y selección de vocabulario asistida por GPT (`EinkWordsGPT`).
- Herramienta práctica de seguridad en shell para flujos de borrado reversible.
- Utilidades centradas en scripts para revisión de tráfico DNS/dominio y conversión de repositorio a texto.
- Soporte de documentación multilingüe mediante `i18n/`.

## Requisitos previos

Generales:
- Git
- Se recomienda Python 3.9+

Para `code/EinkWordsGPT`:
- Raspberry Pi (la documentación del proyecto menciona Raspberry Pi 5)
- Pantalla e-ink Waveshare de 7.3 pulgadas y 7 colores con soporte del driver Python (`waveshare_epd`)
- Paquetes de Python usados en el código: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (se usa `sqlite3` de la biblioteca estándar de Python)
- Clave de API de OpenAI configurada en variables de entorno (el código inicializa `OpenAI()` directamente)

Para `vlogs/chatgpt-traffic`:
- `dnspython`

Para `scripts/lazy-care/SafeShell`:
- Shell Bash o Zsh con acceso a `realpath`, `mv` y `/bin/rm`

## Instalación

Clona el repositorio:

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Instala dependencias comunes de Python (base de uso general del repositorio):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Nota: `code/EinkWordsGPT/README.md` menciona `requirements.txt`, pero actualmente no existe `requirements.txt` en este repositorio. Instala los paquetes manualmente como arriba.

## Uso

### 1) EinkWordsGPT (flujo local con hardware)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # prueba opcional de hardware/pantalla
python words_gpt.py        # ejecuta el bucle de pantalla (actualiza aproximadamente cada 300s)
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

Usa los comandos:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Resolver de tráfico de ChatGPT

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Fusionador de repositorio a texto

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Nota: `convert-repo-to-merged-text.py` actualmente usa rutas fijas (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Edita esas constantes antes de ejecutarlo en otro repositorio.

## Configuración

### Configuración de OpenAI (`code/EinkWordsGPT`)

El código crea el cliente con:

```python
client = OpenAI()
```

Por lo tanto, configura tus credenciales de API con el enfoque estándar de variables de entorno de OpenAI antes de ejecutar los scripts.

### Ruta de la base de datos (`code/EinkWordsGPT`)

Valor predeterminado en el código:

```python
db_path = 'words_phonetics.db'
```

Asegúrate de que `words_phonetics.db` exista en `code/EinkWordsGPT/` (actualmente está incluido en este repositorio).

### Ubicación de la papelera de SafeShell

`saferm`/`unrm`/`removeitanyway` usan una ruta base fija:

```bash
/mnt/disk/BIN/ROOT
```

Ajusta esta ruta en `scripts/lazy-care/SafeShell/safeshell_functions.sh` si tu entorno es distinto.

## Ejemplos

- Demos de tarjetas de vocabulario en e-ink en `demos/`:
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

- Este es un repositorio vitrina multiproyecto con código local y enlaces a proyectos externos.
- Actualmente no se proporciona un gestor de paquetes o manifiesto de build a nivel raíz (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` no están presentes en la raíz).
- Varios sub-README tienen formato de plantilla y pueden estar parcialmente desactualizados respecto al layout de archivos actual; los comandos de este README están alineados con las rutas/scripts que existen hoy.
- `README_EN.md` y `README_CN.md` existen como variantes heredadas; `README.md` + `i18n/*` es la estructura multilingüe activa.

## Solución de problemas

- `ModuleNotFoundError` para paquetes de Python:
  - Reinstala dependencias con `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` en `EinkWordsGPT`:
  - Instala el driver/biblioteca Python de e-paper de Waveshare en tu entorno Raspberry Pi.

- Errores de autenticación de OpenAI:
  - Verifica que tu clave de API de OpenAI esté configurada en variables de entorno antes de ejecutar `words_gpt.py` o `words_update.py`.

- `saferm`/`unrm` no se encuentran después de la configuración:
  - Confirma que cargaste el archivo rc correcto de la shell y que añadiste `safeshell_functions.sh` correctamente.

- `unrm` no puede restaurar archivos:
  - Comprueba que tu ruta de restauración coincida con el layout de papelera espejada de SafeShell en `/mnt/disk/BIN/ROOT`.

- El script `repo2text` no genera salida:
  - Actualiza `source_directory` en `convert-repo-to-merged-text.py` a una carpeta existente.

## Hoja de ruta

- Ampliar la paridad del README raíz en todos los archivos i18n (actualmente muchos idiomas son resúmenes).
- Añadir documentación de instalación específica por entorno para los drivers e-ink de Waveshare.
- Añadir manifiestos de dependencias reproducibles a nivel raíz para herramientas locales.
- Añadir scripts de validación/pruebas para utilidades críticas.
- Continuar consolidando enlaces a proyectos externos con demos locales más ricos.

## Introducción

The Art of Lazying presenta la pereza estratégica como una forma de optimizar el uso de energía y centrarse en lo que realmente importa. Este repositorio explora cómo la pereza intencional puede conducir a mayor productividad, creatividad y bienestar.

## La teoría del Lazying

Una introducción integral a los principios de la pereza estratégica, centrada en cómo maximizar productividad y bienestar mediante la priorización, delegación y automatización de tareas.

El principio clave es aplicar la regla 80/20 de Pareto a la vida diaria: identificar el 20% de actividades que produce el 80% de los resultados deseados.

## Consejos y trucos prácticos

Una colección de consejos accionables para aplicar principios de lazying en el trabajo, las relaciones y el autocuidado:
- Automatizar tareas repetitivas
- Usar la Técnica Pomodoro para la gestión del tiempo
- Crear sistemas que reduzcan la fatiga de decisión
- Aprovechar herramientas de IA como apoyo

## Casos de uso

Ejemplos reales que muestran cómo los principios de lazying resuelven problemas y mejoran la eficiencia:
- Cómo emprendedores usan delegación y automatización para enfocarse en el crecimiento del negocio
- Cómo académicos optimizan sus flujos de investigación
- Cómo creadores de contenido optimizan su proceso de producción

## Agentes de IA y automatización

Explora el desarrollo de agentes de IA y herramientas de automatización que simplifican tareas:
- Uso de ChatGPT como asistente personal
- Construcción de flujos de automatización personalizados
- Creación de pantallas e-ink para aprendizaje pasivo

## Aprendizaje de idiomas y vlogs

Recursos y técnicas para aprender idiomas de forma eficiente, además de vlogs que documentan la ruta del lazying:
- Creación de aprendizaje de idiomas personalizado con repetición espaciada
- Implementación de técnicas de aprendizaje inmersivo
- Construcción de proyectos que fomentan el aprendizaje pasivo

## Contribuciones de la comunidad

Comparte tus propias experiencias, consejos e ideas sobre pereza estratégica:
- Foro para intercambiar hacks de productividad
- Herramientas y plantillas para rutinas diarias
- Proyectos colaborativos para eficiencia lazy

## Contacto

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## Soporte / Donaciones

<div align="center">
<table style="margin:0 auto; text-align:center; border-collapse:collapse;">
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate">https://chat.lazying.art/donate</a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate"><img src="../figs/donate_button.svg" alt="Donate" height="44"></a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://paypal.me/RongzhouChen">
        <img src="https://img.shields.io/badge/PayPal-Donate-003087?logo=paypal&logoColor=white" alt="Donate with PayPal">
      </a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400">
        <img src="https://img.shields.io/badge/Stripe-Donate-635bff?logo=stripe&logoColor=white" alt="Donate with Stripe">
      </a>
    </td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>WeChat</strong></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><strong>Alipay</strong></td>
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="WeChat QR" src="../figs/donate_wechat.png" width="240"/></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="Alipay QR" src="../figs/donate_alipay.png" width="240"/></td>
  </tr>
</table>
</div>

Enlaces adicionales de financiación desde `.github/FUNDING.yml`:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## Contribuir

Se agradecen contribuciones en código, documentación, ejemplos y traducciones.

1. Haz un fork del repositorio.
2. Crea una rama (`git checkout -b feature/your-feature`).
3. Realiza cambios con mensajes de commit claros.
4. Abre un Pull Request describiendo motivación e impacto.

Si no sabes por dónde empezar:
- Mejora documentación de instalación para una herramienta local.
- Añade pruebas o scripts de validación para utilidades existentes.
- Mejora paridad/calidad de una variante `i18n/README.*.md`.

## Licencia

Este repositorio incluye el texto de licencia GPLv3 en la raíz (`LICENSE`) y en varias subcarpetas.

Nota: Algunos README de subproyectos mencionan MIT. Hasta que se aclare cada submódulo, trata el repositorio raíz como regido por GPLv3 y verifica por subproyecto si planeas redistribuir código de forma independiente.
