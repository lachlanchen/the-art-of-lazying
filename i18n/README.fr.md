[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="Bannière LazyingArt" />
</p>

> Remarque : ce dépôt a été migré. Le développement actif continue sur https://github.com/lachlanchen/the-art-of-lazying
> 本仓库已迁移：请前往 https://github.com/lachlanchen/the-art-of-lazying 关注更新
> このリポジトリは移行しました → https://github.com/lachlanchen/the-art-of-lazying

# The Art of Lazying

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](../LICENSE)
[![Repository Status](https://img.shields.io/badge/status-legacy%20archive-orange)](https://github.com/lachlanchen/the-art-of-lazying)
[![Migration](https://img.shields.io/badge/active_repo-the--art--of--lazying-success)](https://github.com/lachlanchen/the-art-of-lazying)
[![Legacy Repo](https://img.shields.io/badge/repo-the--art--of--lazying--legacy-lightgrey)](https://github.com/lachlanchen/the-art-of-lazying-legacy)

Un dépôt qui promeut la paresse stratégique pour une vie plus simple et productive, couvrant des agents IA, l'apprentissage des langues et des vlogs avec des conseils pratiques et des cas d'usage concrets.

![Démo EinkWordsGPT](../demos/words_card_arabic.JPG)

## Table des matières

- [Vue d'ensemble](#vue-densemble)
- [Projets](#projets)
- [Outils d'automatisation](#outils-dautomatisation)
- [Structure des dossiers](#structure-des-dossiers)
- [Introduction](#introduction)
- [La théorie du Lazying](#la-théorie-du-lazying)
- [Conseils et astuces pratiques](#conseils-et-astuces-pratiques)
- [Cas d'usage](#cas-dusage)
- [Agents IA et automatisation](#agents-ia-et-automatisation)
- [Apprentissage des langues et vlogs](#apprentissage-des-langues-et-vlogs)
- [Contributions de la communauté](#contributions-de-la-communauté)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Configuration](#configuration)
- [Exemples](#exemples)
- [Notes de développement](#notes-de-développement)
- [Dépannage](#dépannage)
- [Feuille de route](#feuille-de-route)
- [Contribuer](#contribuer)
- [Licence](#licence)
- [Remerciements](#remerciements)
- [Contact](#contact)

## Vue d'ensemble

`the-art-of-lazying-legacy` est un dépôt umbrella organisé autour de la paresse stratégique :

- Du contenu conceptuel sur l'application de la philosophie "lazying" au travail et à la vie.
- Des artefacts de code pratiques, notamment l'apprentissage linguistique e-ink + GPT (`code/EinkWordsGPT`).
- Des scripts utilitaires pour des workflows plus sûrs (`scripts/lazy-care/SafeShell`).
- Des outils orientés vlog et des extraits d'automatisation (`vlogs/`).
- Des ressources de démonstration et des exemples (`demos/`, `examples/`, `figs/`).

| Instantané | Valeur |
|---|---|
| Rôle du dépôt | Archive legacy + carte d'idées |
| Développement actif | https://github.com/lachlanchen/the-art-of-lazying |
| Fichiers README multilingues | `README.md`, `README_CN.md`, `README_EN.md` |
| Répertoire i18n | `i18n/` (présent) |

Ce dépôt reste utile comme archive legacy et carte d'idées, tandis que le développement actif a été déplacé vers le dépôt migré mentionné ci-dessus.

## Projets

### 🤖 Outils créatifs propulsés par l'IA

| Projet | Description | Démo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Écran e-ink avec apprentissage de vocabulaire propulsé par GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse de l'origine des mots et présentation sous forme de graphe. | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Outils pour apprendre les langues efficacement avec un effort minimal | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Sous-titrage vidéo et image avec embeddings OpenAI CLIP + décodeur GPT | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Outil de sous-titrage vidéo : extraction de keyframes avec Katna/OpenCV et génération de sous-titres avec un modèle ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcription multilingue avec détection de langue fine | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Briser les barrières linguistiques pour des échanges créatifs mondiaux | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Génération automatique de métadonnées pour les vidéos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Outil de montage vidéo automatique propulsé par l'IA avec transcription, auto-sous-titres, mise en évidence et génération de métadonnées | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Rationalisation des workflows de publication de contenu | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Système automatisé de surveillance, traitement et publication de contenus vidéo vers plusieurs plateformes | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Techniques avancées pour utiliser efficacement les assistants IA | |

## Outils d'automatisation

Le dépôt inclut des utilitaires d'automatisation locaux exécutables directement.

| Chemin | Objectif |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Boucle continue de rendu de cartes de mots e-ink (rafraîchissement par défaut toutes les 300 s). |
| `code/EinkWordsGPT/words_update.py` | Actualisation par lot et ciblée des détails des mots via une logique adossée à OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Test matériel e-paper Waveshare 7.3". |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Fonctions shell `saferm`, `unrm` et `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Résolution domaine-vers-IP + sortie dédupliquée. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Fusionne les fichiers `.py` par sous-répertoire en fichiers `.txt`. |

## Structure des dossiers

### Structure actuelle du dépôt (exacte)

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
├── i18n/                      # actuellement présent
├── scripts/
│   └── lazy-care/
└── vlogs/
```

### Structure conceptuelle d'origine (préservée)

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

> Remarque : la carte conceptuelle ci-dessus est volontairement conservée depuis d'anciennes versions du README. Le bloc "Structure actuelle du dépôt" reflète l'arborescence concrète de ce dépôt legacy.

## Introduction

The Art of Lazying présente la paresse stratégique comme une manière d'optimiser l'usage de l'énergie et de se concentrer sur ce qui compte vraiment. Ce dépôt explore comment une paresse intentionnelle peut mener à une productivité, une créativité et un bien-être plus élevés.

## La théorie du Lazying

Une introduction complète aux principes de la paresse stratégique, axée sur la manière de maximiser la productivité et le bien-être en priorisant, déléguant et automatisant les tâches.

Le principe clé consiste à appliquer la règle 80/20 de Pareto à la vie quotidienne : identifier les 20 % d'activités qui produisent 80 % des résultats souhaités.

## Conseils et astuces pratiques

Une collection de conseils actionnables pour appliquer les principes du lazying au travail, aux relations et au soin de soi :

- Automatiser les tâches répétitives
- Utiliser la technique Pomodoro pour la gestion du temps
- Créer des systèmes qui réduisent la fatigue décisionnelle
- Tirer parti des outils IA pour obtenir de l'aide

## Cas d'usage

Exemples concrets montrant comment les principes du lazying résolvent des problèmes et améliorent l'efficacité :

- Comment les entrepreneurs utilisent la délégation et l'automatisation pour se concentrer sur la croissance de leur entreprise
- Comment les universitaires rationalisent leurs workflows de recherche
- Comment les créateurs de contenu optimisent leur processus de production

## Agents IA et automatisation

Explorez le développement d'agents IA et d'outils d'automatisation qui simplifient les tâches :

- Utiliser ChatGPT comme assistant personnel
- Construire des workflows d'automatisation personnalisés
- Créer des écrans e-ink pour l'apprentissage passif

## Apprentissage des langues et vlogs

Ressources et techniques pour un apprentissage efficace des langues, ainsi que des vlogs documentant le parcours lazying :

- Créer un apprentissage linguistique personnalisé avec la répétition espacée
- Mettre en œuvre des techniques d'apprentissage immersif
- Construire des projets qui encouragent l'apprentissage passif

## Contributions de la communauté

Partagez vos propres expériences, astuces et idées sur la paresse stratégique :

- Forum pour échanger des astuces de productivité
- Outils et modèles pour les routines quotidiennes
- Projets collaboratifs pour une efficacité "lazy"

## Prérequis

Le dépôt contient plusieurs scripts indépendants, donc les prérequis varient selon les modules.

Base commune :

- Python 3.9+
- `pip`
- Git

Signaux spécifiques aux projets à partir des fichiers source :

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (pour les workflows matériels e-paper)
- `sqlite3` (bibliothèque standard)

Exigences matérielles pour l'exécution complète de `EinkWordsGPT` :

- Raspberry Pi (la documentation du projet mentionne Raspberry Pi 5)
- Panneau e-ink Waveshare 7 couleurs de 7,3 pouces

## Installation

Puisqu'il n'existe pas de manifeste de dépendances à la racine, installez les dépendances manuellement pour le module que vous souhaitez exécuter.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Dépendance optionnelle/matérielle :

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

Configuration SafeShell :

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
```

## Utilisation

### 1) Exécuter la boucle d'affichage EinkWordsGPT

```bash
cd code/EinkWordsGPT
python words_gpt.py
```

### 2) Revérifier/mettre à jour les détails des mots

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 3) Tester le panneau Waveshare 7,3 pouces

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py
```

### 4) Résoudre les domaines liés à ChatGPT et produire la sortie IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py
```

### 5) Fusionner les fichiers Python par dossier pour créer des bundles texte adaptés à l'IA

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Utiliser un workflow de suppression de fichiers plus sûr

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Configuration

### Identifiants OpenAI

`EinkWordsGPT` et les scripts de mise à jour utilisent `OpenAI()` depuis le SDK officiel et attendent des identifiants configurés dans votre environnement.

Hypothèse (recommandée) :

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Emplacement de la base de données

`code/EinkWordsGPT/words_gpt.py` et `words_update.py` utilisent :

- `db_path = 'words_phonetics.db'`

Exécutez les scripts depuis `code/EinkWordsGPT` ou mettez à jour les chemins si vous les lancez ailleurs.

### Racine de corbeille SafeShell

`saferm`/`unrm`/`removeitanyway` utilisent actuellement un chemin de base fixe :

- `/mnt/disk/BIN/ROOT`

Assurez-vous que ce chemin existe et est inscriptible avant de vous reposer sur `saferm`.

### Chemins Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` contient actuellement des chemins codés en dur :

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Modifiez ces constantes pour correspondre à votre projet local.

## Exemples

### Exemple : cycle de carte d'apprentissage e-ink

- Le script choisit (ou récupère) les détails d'un mot.
- La carte de mot affiche la phonétique, la segmentation syllabique et des indices de synonymes japonais.
- L'écran se rafraîchit toutes les 5 minutes (`time.sleep(300)`).

### Exemple : workflow de suppression sûre

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Exemple : fichier de sortie domaine/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Notes de développement

- Il s'agit d'un dépôt legacy ; le développement actif se trouve sur : https://github.com/lachlanchen/the-art-of-lazying
- Le contenu de premier niveau est curatorial et renvoie vers de nombreux dépôts externes.
- `i18n/` existe mais est actuellement vide ; les README de langue se trouvent actuellement au niveau racine.
- Aucun `requirements.txt` ni `pyproject.toml` à la racine n'est présent.

Note de compatibilité préservée :

- D'anciennes documentations dans les sous-dossiers peuvent mentionner des scripts (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) qui sont désormais consolidés dans `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Dépannage

- `ModuleNotFoundError` : installez les paquets Python manquants listés dans [Prérequis](#prérequis).
- Erreurs d'authentification `openai` : confirmez que `OPENAI_API_KEY` est exportée dans votre shell.
- Problèmes d'exécution Waveshare : vérifiez la configuration SPI/périphériques et installez les dépendances fournisseur sur le Pi.
- `saferm` semble ne rien faire : vérifiez que `/mnt/disk/BIN/ROOT` existe et dispose des permissions d'écriture.
- `repo2text` ne génère aucun fichier : assurez-vous que `source_directory` pointe vers un dossier existant contenant des fichiers `.py`.
- Anomalies de domaines `chatgpt-traffic` : vérifiez et nettoyez la liste `domains` du script avant usage en production.

## Feuille de route

- Conserver ce dépôt comme archive legacy stable avec des pointeurs clairs vers les projets actifs.
- Améliorer les manifestes de dépendances pour chaque sous-module exécutable.
- Ajouter une mise en page i18n cohérente sous `/i18n` dans les futures révisions.
- Étendre les exemples pratiques et les guides d'installation reproductibles pour les workflows matériels et non matériels.

## Contribuer

Les contributions sont les bienvenues.

1. Forkez le projet.
2. Créez votre branche de fonctionnalité (`git checkout -b feature/AmazingFeature`).
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`).
4. Poussez votre branche (`git push origin feature/AmazingFeature`).
5. Ouvrez une Pull Request.

Vous pouvez aussi contribuer en :

- Proposant des améliorations des workflows de paresse stratégique.
- Signalant des problèmes dans les scripts ou la documentation.
- Améliorant la reproductibilité de l'installation pour les parcours matériel/logiciel.

## Licence

Ce dépôt est sous licence GNU General Public License v3.0. Voir [LICENSE](../LICENSE).

## Remerciements

Un grand merci aux contributeurs, à l'équipe OpenAI et aux communautés Raspberry Pi / makers qui soutiennent l'expérimentation autour de systèmes d'apprentissage à faible friction.

## Contact

- Site web : [lazying.art](https://lazying.art)
- GitHub : [lachlanchen](https://github.com/lachlanchen)
- Email : lach@lazying.art
