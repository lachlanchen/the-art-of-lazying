[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner — apps and four buddies](https://github.com/lachlanchen/LazyingArtWebsite/raw/main/media/brand/lazyingart-intro.gif)](https://lazying.art)

# L'Art de la paresse

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)
[![GitHub stars](https://img.shields.io/github/stars/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/lachlanchen/the-art-of-lazying?style=social)](https://github.com/lachlanchen/the-art-of-lazying/network/members)
[![Last commit](https://img.shields.io/github/last-commit/lachlanchen/the-art-of-lazying)](https://github.com/lachlanchen/the-art-of-lazying/commits/main)

Un dépôt axé sur la paresse stratégique pour une vie plus simple et à plus fort levier, couvrant les agents IA, l'apprentissage des langues, l'automatisation pratique et des flux de travail réels orientés vlogs.

| Focus | Ce que contient ce README |
|---|---|
| 🤖 Automatisation | Outils, scripts et workflows pratiques utilisables localement |
| 🧠 Apprentissage | Projets centrés sur la langue et exemples pour des habitudes d'étude efficaces |
| 📚 Partage | Documentation multilingue, liens de projet et guides de contribution |

![EinkWordsGPT Demo](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Table des matières

- [Vue d'ensemble](#vue-densemble)
- [Projets](#projets)
- [Structure du dépôt](#structure-du-dépôt)
- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Configuration](#configuration)
- [Exemples](#exemples)
- [Notes de développement](#notes-de-développement)
- [Dépannage](#dépannage)
- [Feuille de route](#feuille-de-route)
- [Introduction](#introduction)
- [Théorie de la paresse](#théorie-de-la-paresse)
- [Astuces pratiques](#astuces-pratiques)
- [Cas d'usage](#cas-dusage)
- [Agents IA et automatisation](#agents-ia-et-automatisation)
- [Apprentissage des langues et vlogs](#apprentissage-des-langues-et-vlogs)
- [Contributions de la communauté](#contributions-de-la-communauté)
- [❤️ Support](#-support)
- [Contact](#contact)
- [Contribuer](#contribuer)
- [Licence](#licence)

## Vue d'ensemble

`the-art-of-lazying` est un dépôt central pour la paresse stratégique: automatiser les tâches répétitives, améliorer les flux d'apprentissage des langues et documenter des expériences concrètes via des scripts et des vlogs.

| En bref | Détails |
|---|---|
| 🎯 Thème central | Paresse stratégique pour la productivité, l'apprentissage et la création |
| 🧩 Style du dépôt | Hybride d'outils locaux + projets externes sélectionnés |
| 🛠️ Points forts locaux | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Documentation | README racine + variantes multilingues dans `i18n/` |

Ce dépôt contient les deux:
- Liens vers des projets externes connexes.
- Outils et code locaux, notamment:
  - `code/EinkWordsGPT` (Raspberry Pi + affichage e-paper Waveshare + apprentissage de vocabulaire assisté par OpenAI).
  - `scripts/lazy-care/SafeShell` (fonctions shell de suppression/restauration sécurisées).
  - `vlogs/chatgpt-traffic` et `vlogs/repo2text` (petits utilitaires Python).

## Projets

### 🚀 Outils créatifs assistés par IA

| Projet | Description | Démo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Écran e-paper avec apprentissage de mots basé sur GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse de l'origine des mots et visualisation sous forme de graphe. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Outils pour un apprentissage linguistique efficace avec peu d'effort | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Légendage vidéo et image avec embeddings OpenAI CLIP + décodeur GPT | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Outil de légendage vidéo : extraction d'images-clés avec Katna/OpenCV et génération avec un modèle ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcription multilingue avec détection fine de la langue | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Briser les barrières linguistiques pour les échanges créatifs mondiaux | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Génération automatique de métadonnées vidéo | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Outil de montage vidéo automatique assisté par l'IA, avec transcription, sous-titrage, mise en évidence et génération de métadonnées | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Rationalisation des flux de publication de contenu | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Système automatisé de suivi, traitement et publication de vidéos sur plusieurs plateformes | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Techniques avancées pour utiliser efficacement les assistants IA | |

### ⚙️ Outils d'automatisation (locaux dans ce dépôt)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh` : suppression shell plus sûre (`saferm`), restauration (`unrm`) et suppression permanente explicite (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py` : résolveur domaine-vers-IP et générateur de sortie dédupliquée.
- `vlogs/repo2text/convert-repo-to-merged-text.py` : fusionne les fichiers Python par répertoire en lots texte pour analyse assistée par IA.

## Structure du dépôt

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

Note: les schémas de dossier plus anciens dans des variantes précédentes du README faisaient référence à des chemins abstraits (par exemple `book/`, `code/ai-agents/`) qui ne correspondent pas exactement à l'arborescence actuelle du dépôt. La structure ci-dessus reflète les fichiers actuels.

## Fonctionnalités

- Cadre de paresse stratégique pour la productivité, l'apprentissage et les flux de contenu.
- Portefeuille de projets IA sélectionnés couvrant transcription, sous-titrage, traduction et automatisation de publication.
- Apprentissage des langues intégré au matériel avec sélection de mots assistée par GPT (`EinkWordsGPT`).
- Outils shell pratiques pour des flux de suppression réversibles.
- Utilitaires orientés scripts pour vérifier DNS/traﬁc de domaines et convertir des dépôts en texte.
- Documentation multilingue via `i18n/`.

## Prérequis

Général:
- Git
- Python 3.9+ recommandé

Pour `code/EinkWordsGPT`:
- Raspberry Pi (la documentation du projet mentionne Raspberry Pi 5)
- Afficheur e-paper Waveshare 7,3 pouces 7 couleurs avec support du pilote Python (`waveshare_epd`)
- Packages Python utilisés dans le code: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (la bibliothèque standard Python `sqlite3` est utilisée)
- Clé API OpenAI configurée dans l'environnement (le code initialise `OpenAI()` directement)

Pour `vlogs/chatgpt-traffic`:
- `dnspython`

Pour `scripts/lazy-care/SafeShell`:
- Shell Bash ou Zsh avec accès à `realpath`, `mv` et `/bin/rm`

## Installation

Cloner le dépôt:

```bash

git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Installer les dépendances Python les plus couramment utilisées (base commune au dépôt):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Note : `code/EinkWordsGPT/README.md` mentionne `requirements.txt`, mais aucun `requirements.txt` n'est actuellement présent dans ce dépôt. Installez les packages manuellement comme indiqué ci-dessus.

## Utilisation

### 1) EinkWordsGPT (flux matériel local)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

Script optionnel de maintenance de la base de données:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (workflow de suppression plus sûre)

Charger les fonctions shell:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

Utiliser les commandes:

```bash
saferm /path/to/file_or_directory
unrm /path/to/file_or_directory
removeitanyway /path/to/file_or_directory
```

### 3) Résolveur ChatGPT Traffic

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 4) Fusionneur repo-to-text

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

Note : `convert-repo-to-merged-text.py` utilise actuellement des chemins codés en dur (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Modifiez ces constantes avant d'exécuter le script contre un autre dépôt.

## Configuration

### Configuration OpenAI (`code/EinkWordsGPT`)

Le code crée le client avec:

```python
client = OpenAI()
```

Configurez donc vos identifiants API via l'approche standard des variables d'environnement OpenAI avant d'exécuter les scripts.

### Chemin de la base de données (`code/EinkWordsGPT`)

Valeur par défaut dans le code:

```python
db_path = 'words_phonetics.db'
```

Assurez-vous que `words_phonetics.db` existe dans `code/EinkWordsGPT/` (il est actuellement inclus dans ce dépôt).

### Emplacement de la corbeille SafeShell

`saferm`/`unrm`/`removeitanyway` utilisent un chemin de base fixe:

```bash
/mnt/disk/BIN/ROOT
```

Adaptez ce chemin dans `scripts/lazy-care/SafeShell/safeshell_functions.sh` si votre environnement diffère.

## Exemples

- Démonstrations de cartes de vocabulaire e-paper dans `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Notes et ressources pour ChachaGPT :
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Notes de développement

- Il s'agit d'un dépôt vitrine multi-projets avec du code local et des liens vers des projets externes.
- Aucun gestionnaire de paquets ou manifeste de build n'est actuellement fourni au niveau racine (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` ne sont pas présents à la racine).
- Plusieurs sous-README sont de type modèle et peuvent être partiellement obsolètes par rapport à la structure actuelle des fichiers; les commandes de ce README sont alignées avec les chemins/scripts réellement présents.
- `README_EN.md` et `README_CN.md` existent comme variantes historiques; `README.md` + `i18n/*` constituent la structure multilingue active.

## Dépannage

- `ModuleNotFoundError` pour des packages Python:
  - Réinstallez les dépendances avec `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` dans `EinkWordsGPT`:
  - Installez le pilote/bibliothèque e-paper Waveshare sur votre environnement Raspberry Pi.

- Erreurs d'authentification OpenAI:
  - Vérifiez que votre clé API OpenAI est bien définie dans les variables d'environnement avant d'exécuter `words_gpt.py` ou `words_update.py`.

- `saferm`/`unrm` introuvables après la configuration:
  - Vérifiez que vous avez sourcé le bon fichier rc de votre shell et que `safeshell_functions.sh` a bien été ajouté.

- `unrm` ne peut pas restaurer les fichiers:
  - Vérifiez que le chemin de restauration correspond à la structure de la corbeille SafeShell sous `/mnt/disk/BIN/ROOT`.

- Le script `repo2text` ne produit aucun résultat:
  - Mettez à jour `source_directory` dans `convert-repo-to-merged-text.py` avec un dossier existant.

## Feuille de route

- Étendre la cohérence du README racine à tous les fichiers `i18n` (actuellement des résumés dans plusieurs langues).
- Ajouter des docs de configuration adaptées à l'environnement pour les pilotes e-paper Waveshare.
- Ajouter des manifestes de dépendances reproductibles au niveau racine pour les outils locaux.
- Ajouter des scripts de validation/test pour les utilitaires critiques.
- Continuer à regrouper les liens de projets externes avec des démonstrations locales plus riches.

## Introduction

L'Art de la paresse présente la paresse stratégique comme une façon d'optimiser l'énergie et de se concentrer sur ce qui compte vraiment. Ce dépôt explore comment la paresse intentionnelle peut mener à une productivité, une créativité et un bien-être accrus.

## La théorie de la paresse

Une présentation complète des principes de la paresse stratégique, axée sur l'optimisation de la productivité et du bien-être grâce à la priorisation, la délégation et l'automatisation des tâches.

Le principe clé consiste à appliquer la règle de Pareto (80/20) à la vie quotidienne: identifier les 20% d'activités qui produisent 80% des résultats attendus.

## Astuces pratiques

Une collection de conseils actionnables pour appliquer des principes de paresse au travail, aux relations et au bien-être personnel:
- Automatiser les tâches répétitives
- Utiliser la technique Pomodoro pour la gestion du temps
- Créer des systèmes qui réduisent la fatigue de décision
- Tirer parti des outils IA pour obtenir de l'aide

## Cas d'usage

Des exemples concrets montrant comment les principes de la paresse résolvent des problèmes et améliorent l'efficacité:
- Comment les entrepreneurs utilisent la délégation et l'automatisation pour se concentrer sur la croissance commerciale
- Comment les universitaires rationalisent leurs flux de recherche
- Comment les créateurs de contenu optimisent leur processus de production

## Agents IA et automatisation

Découvrez le développement d'agents IA et d'outils d'automatisation qui simplifient les tâches:
- Utiliser ChatGPT comme assistant personnel
- Construire des flux d'automatisation personnalisés
- Créer des affichages e-paper pour un apprentissage passif

## Apprentissage des langues et vlogs

Ressources et techniques pour un apprentissage linguistique efficace, ainsi que des vlogs documentant le parcours de la paresse:
- Créer un apprentissage linguistique personnalisé avec répétition espacée
- Mettre en place des méthodes d'immersion
- Construire des projets qui favorisent l'apprentissage passif

## Contributions de la communauté

Partagez vos expériences, conseils et idées sur la paresse stratégique:
- Forum d'échange de hacks de productivité
- Outils et modèles pour les routines quotidiennes
- Projets collaboratifs pour une efficacité paresseuse

## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |

## Contact

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

## Contribuer

Les contributions sont les bienvenues sur le code, la documentation, les exemples et les traductions.

1. Forker le dépôt.
2. Créer une branche (`git checkout -b feature/your-feature`).
3. Apporter des changements avec des messages de commit clairs.
4. Ouvrir une Pull Request décrivant la motivation et l'impact.

Si vous ne savez pas par où commencer:
- Améliorer la documentation d'installation d'un outil local.
- Ajouter des tests ou scripts de validation pour les utilitaires existants.
- Améliorer la cohérence/qualité d'une variante `i18n/README.*.md`.

## Licence

Ce dépôt inclut le texte de la licence GPLv3 à la racine (`LICENSE`) et dans plusieurs sous-dossiers.

Note: Certains README de sous-projets mentionnent MIT. Tant que chaque sous-projet n'est pas clarifié, considérez le dépôt racine comme régi par GPLv3 et vérifiez chaque sous-projet si vous envisagez de redistribuer le code indépendamment.
