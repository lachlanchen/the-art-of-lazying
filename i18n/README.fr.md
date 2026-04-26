[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


[![LazyingArt banner](https://github.com/lachlanchen/lachlanchen/raw/main/figs/banner.png)](https://github.com/lachlanchen/lachlanchen/blob/main/figs/banner.png)

> Remarque : ce dépôt a été migré. Le développement actif continue sur https://github.com/lachlanchen/the-art-of-lazying
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

Un dépôt qui promeut la paresse stratégique pour une vie simplifiée et productive, englobant les agents IA, l'apprentissage des langues et des vlogs avec des conseils pratiques et des cas d'usage réels.

![Démo d'EinkWordsGPT](https://raw.githubusercontent.com/lachlanchen/the-art-of-lazying/refs/heads/main/code/EinkWordsGPT/demo.jpg)

## Table des matières

- [Vue d'ensemble](#vue-densemble)
- [Projets](#projets)
- [Outils d'automatisation](#outils-dautomatisation)
- [Structure des dossiers](#structure-des-dossiers)
- [Introduction](#introduction)
- [La théorie de la paresse](#la-théorie-de-la-paresse)
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

## Liens rapides

| Besoin | Commencer ici |
|---|---|
| Voir la carte du contenu principal | [Vue d'ensemble](#vue-densemble) |
| Installer les dépendances | [Prérequis](#prérequis) |
| Exécuter des exemples | [Utilisation](#utilisation) |
| Résoudre les problèmes courants | [Dépannage](#dépannage) |
| Contribuer | [Contribuer](#contribuer) |

## Vue d'ensemble

`the-art-of-lazying-legacy` est un dépôt-umbrellle rassemblant des idées autour de la paresse stratégique :

- Des contenus conceptuels sur l'application de la philosophie du "lazying" au travail et à la vie.
- Des artefacts de code concrets, dont l'apprentissage de vocabulaire avec écran e-ink + GPT (`code/EinkWordsGPT`).
- Des scripts utilitaires pour des flux de travail plus sûrs (`scripts/lazy-care/SafeShell`).
- Des outils pour vlogs et des snippets d'automatisation (`vlogs/`).
- Des ressources de démonstration et des exemples (`demos/`, `examples/`, `figs/`).

| Instantané | Valeur |
|---|---|
| Rôle du dépôt | Archive legacy + carte d'idées |
| Développement actif | https://github.com/lachlanchen/the-art-of-lazying |
| Fichiers README multilingues | `README.md`, `README_CN.md`, `README_EN.md` |
| Répertoire i18n | `i18n/` (présent) |
| Apprentissage des langues | Répétition espacée + flux GPT |
| Focus de l'automatisation | Scripts, sous-titres, publication et workflows matériels |

Ce dépôt reste utile en tant qu'archive legacy et carte d'idées, tandis que le développement actif a migré vers le dépôt lié ci-dessus.

---

## Projets

### 🤖 Outils créatifs alimentés par l'IA

| Projet | Description | Démo |
|---|---|---|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Affichage e-ink avec apprentissage lexical propulsé par GPT | ![WordsOrigin](../demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse de l'origine des mots et présentation sous forme de graphe | ![WordsOrigin](../demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Outils pour apprendre une langue avec un effort minimal | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Sous-titrage vidéo et image avec embeddings OpenAI CLIP + décodeur GPT | ![AutoCaption](../demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Outil de sous-titrage vidéo : extraction de keyframes avec Katna/OpenCV et génération de sous-titres avec un modèle ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcription multilingue avec détection linguistique fine | ![AutoTranscription](../demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Supprimer les barrières linguistiques pour un échange créatif mondial | ![AutoTranslation](../demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Génération automatique de métadonnées pour les vidéos | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Outil de montage vidéo automatique avec transcription, sous-titrage automatique, surlignage et génération de métadonnées | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Rationalisation des workflows de publication de contenu | ![AutoPublication](../demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Système automatisé pour surveiller, traiter et publier du contenu vidéo sur plusieurs plateformes | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Techniques avancées pour utiliser efficacement les assistants IA | |

## Outils d'automatisation

Le dépôt comprend des utilitaires d'automatisation utilisables localement :

| Chemin | Objectif |
|---|---|
| `code/EinkWordsGPT/words_gpt.py` | Boucle continue de rendu de cartes de mots e-ink (rafraîchissement par défaut toutes les 300 s). |
| `code/EinkWordsGPT/words_update.py` | Actualisation groupée et ciblée des détails des mots via une logique basée sur OpenAI. |
| `code/EinkWordsGPT/epd_7in3f_test.py` | Test matériel de l'e-paper Waveshare 7.3". |
| `scripts/lazy-care/SafeShell/safeshell_functions.sh` | Fonctions shell `saferm`, `unrm` et `removeitanyway`. |
| `vlogs/chatgpt-traffic/chatgpt-traffic.py` | Résolution domaine-vers-IP + sortie dédupliquée. |
| `vlogs/repo2text/convert-repo-to-merged-text.py` | Fusion des fichiers `.py` par sous-répertoire en fichiers `.txt`. |

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

> Note : la carte conceptuelle ci-dessus est volontairement conservée depuis d'anciennes versions du README. Le bloc "Structure actuelle du dépôt" reflète l'arborescence concrète de ce dépôt legacy.

## Introduction

The Art of Lazying présente la paresse stratégique comme une manière d'optimiser l'énergie et de se concentrer sur ce qui compte vraiment. Ce dépôt explore comment une paresse intentionnelle peut conduire à une productivité, une créativité et un bien-être accrus.

## La théorie de la paresse

Une introduction complète aux principes de la paresse stratégique, en se concentrant sur la manière de maximiser la productivité et le bien-être en priorisant, déléguant et automatisant les tâches.

Le principe clé consiste à appliquer la règle 80/20 de Pareto à la vie quotidienne : identifier les 20 % d'activités qui produisent 80 % des résultats attendus.

## Conseils et astuces pratiques

Une collection de conseils actionnables pour appliquer les principes de la paresse au travail, aux relations et au soin de soi :

- Automatiser les tâches répétitives
- Utiliser la technique Pomodoro pour la gestion du temps
- Créer des systèmes qui réduisent la fatigue décisionnelle
- Tirer parti des outils IA pour obtenir de l'aide

## Cas d'usage

Des exemples concrets montrant comment les principes de la paresse résolvent des problèmes et améliorent l'efficacité :

- Comment les entrepreneurs utilisent délégation et automatisation pour se concentrer sur la croissance de leur entreprise
- Comment les chercheurs rationalisent leurs flux de travail de recherche
- Comment les créateurs de contenu optimisent leur processus de production

## Agents IA et automatisation

Explorer le développement d'agents IA et d'outils d'automatisation qui simplifient les tâches :

- Utiliser ChatGPT comme assistant personnel
- Construire des workflows d'automatisation personnalisés
- Créer des écrans e-ink pour l'apprentissage passif

## Apprentissage des langues et vlogs

Ressources et techniques pour un apprentissage de langue efficace, ainsi que des vlogs retraçant le parcours de la paresse :

- Créer un apprentissage de langue personnalisé avec répétition espacée
- Mettre en œuvre des techniques d'immersion
- Construire des projets qui encouragent l'apprentissage passif

## Contributions de la communauté

Partager vos propres expériences, conseils et idées sur la paresse stratégique :

- Forum d'échange de hacks de productivité
- Outils et modèles pour les routines quotidiennes
- Projets collaboratifs pour une efficacité "lazy"

## Prérequis

Le dépôt contient plusieurs scripts indépendants, donc les prérequis varient selon le module.

Base commune :

- Python 3.9+
- `pip`
- Git

Dépendances par module (déduites des fichiers source) :

- `openai`
- `Pillow`
- `pytz`
- `pykakasi`
- `dnspython`
- `waveshare_epd` (pour les flux matériels e-paper)
- `sqlite3` (bibliothèque standard)

Exigences matérielles pour l'exécution complète de `EinkWordsGPT` :

- Raspberry Pi (la documentation du projet mentionne Raspberry Pi 5)
- Panneau e-ink Waveshare 7 couleurs 7,3 pouces

## Installation

Il n'y a pas de manifeste de dépendances à la racine, donc installez les dépendances manuellement pour le module que vous souhaitez exécuter.

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying-legacy.git
cd the-art-of-lazying-legacy
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install openai pillow pytz pykakasi dnspython
```

Dépendance optionnelle/ matérielle :

```bash
# Required for EinkWordsGPT display scripts on supported hardware
pip install waveshare-epd
```

Configuration de SafeShell :

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

### 5) Fusionner les fichiers Python par dossier pour des lots texte optimisés IA

```bash
cd vlogs/repo2text
python convert-repo-to-merged-text.py
```

### 6) Utiliser un flux de suppression de fichiers plus sûr

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm path/to/file
unrm path/to/file
removeitanyway path/to/file
```

## Configuration

### Identifiants OpenAI

`EinkWordsGPT` et les scripts de mise à jour utilisent `OpenAI()` depuis le SDK officiel et attendent les identifiants configurés dans votre environnement.

Hypothèse (recommandée) :

```bash
export OPENAI_API_KEY="your_api_key_here"
```

### Emplacement de la base de données

`code/EinkWordsGPT/words_gpt.py` et `words_update.py` utilisent :

- `db_path = 'words_phonetics.db'`

Exécutez les scripts depuis `code/EinkWordsGPT` ou ajustez les chemins si vous les lancez ailleurs.

### Racine de la corbeille SafeShell

`saferm`/`unrm`/`removeitanyway` utilisent actuellement un chemin de base fixe :

- `/mnt/disk/BIN/ROOT`

Assurez-vous que ce chemin existe et est accessible en écriture avant de vous reposer sur `saferm`.

### Chemins Repo2Text

`vlogs/repo2text/convert-repo-to-merged-text.py` utilise actuellement des chemins codés en dur :

- `source_directory = 'diffraction'`
- `target_directory = 'merged_py_files'`

Modifiez ces constantes pour qu'elles correspondent à votre projet local.

## Exemples

### Exemple : cycle de carte d'apprentissage e-ink

- Le script choisit (ou récupère) les détails d'un mot.
- La carte de mot affiche la phonétique, la segmentation syllabique et des indices de synonymes japonais.
- L'écran se rafraîchit toutes les 5 minutes (`time.sleep(300)`).

### Exemple : flux de suppression sûre

```bash
source scripts/lazy-care/SafeShell/safeshell_functions.sh
saferm ~/Downloads/large_file.zip
unrm ~/Downloads/large_file.zip
```

### Exemple : sortie fichier domaine/IP

```bash
cd vlogs/chatgpt-traffic
python chatgpt-traffic.py > traffic_hosts.txt
```

## Notes de développement

- Il s'agit d'un dépôt legacy; le développement actif est sur : https://github.com/lachlanchen/the-art-of-lazying
- Le contenu de premier niveau est curatif et renvoie vers de nombreux dépôts externes.
- `i18n/` existe et est présent ; les README multilingues y sont désormais stockés.
- Aucun `requirements.txt` ou `pyproject.toml` n'est présent à la racine.

Note de compatibilité préservée :

- D'anciennes documentations dans les sous-dossiers peuvent mentionner des scripts (`saferm.sh`, `unrm.sh`, `removeitanyway.sh`) qui sont désormais consolidés dans `scripts/lazy-care/SafeShell/safeshell_functions.sh`.

## Dépannage

- `ModuleNotFoundError` : installez les paquets Python manquants listés dans [Prérequis](#prérequis).
- Erreurs d'authentification `openai` : vérifiez que `OPENAI_API_KEY` est exportée dans votre shell.
- Problèmes d'exécution Waveshare : vérifiez la configuration SPI/périphérique et installez les dépendances du fournisseur sur le Pi.
- `saferm` semble inactif : vérifiez que `/mnt/disk/BIN/ROOT` existe et dispose des permissions d'écriture.
- `repo2text` ne génère aucun fichier : assurez-vous que `source_directory` pointe vers un dossier existant contenant des fichiers `.py`.
- Anomalies de domaines dans `chatgpt-traffic` : passez en revue et nettoyez la liste `domains` avant usage en production.

## Feuille de route

- Conserver ce dépôt comme archive legacy stable avec des pointeurs clairs vers les projets actifs.
- Améliorer les manifestes de dépendances pour chaque sous-module exécutable.
- Ajouter une mise en page i18n cohérente sous `/i18n` dans les prochaines révisions.
- Étendre les exemples pratiques et les guides d'installation reproductibles pour les flux matériels et non matériels.

## Contribuer

Les contributions sont les bienvenues.

1. Forkez le projet.
2. Créez votre branche de fonctionnalités (`git checkout -b feature/AmazingFeature`).
3. Commitez vos changements (`git commit -m 'Add some AmazingFeature'`).
4. Poussez la branche (`git push origin feature/AmazingFeature`).
5. Ouvrez une Pull Request.

Vous pouvez aussi contribuer en :

- Proposant des améliorations aux workflows de paresse stratégique.
- Signalant des problèmes dans les scripts ou la documentation.
- Améliorant la reproductibilité de l'installation pour les flux matériel/logiciel.

## Licence

Ce dépôt est sous licence GNU General Public License v3.0. Voir [LICENSE](../LICENSE).

## Remerciements

Remerciements spéciaux aux contributeurs, à l'équipe OpenAI et aux communautés Raspberry Pi / makers qui soutiennent l'expérimentation autour de systèmes d'apprentissage à faible friction.

## ❤️ Support

| Donate | PayPal | Stripe |
| --- | --- | --- |
| [![Donate](https://camo.githubusercontent.com/24a4914f0b42c6f435f9e101621f1e52535b02c225764b2f6cc99416926004b7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d4c617a79696e674172742d3045413545393f7374796c653d666f722d7468652d6261646765266c6f676f3d6b6f2d6669266c6f676f436f6c6f723d7768697465)](https://chat.lazying.art/donate) | [![PayPal](https://camo.githubusercontent.com/d0f57e8b016517a4b06961b24d0ca87d62fdba16e18bbdb6aba28e978dc0ea21/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f50617950616c2d526f6e677a686f754368656e2d3030343537433f7374796c653d666f722d7468652d6261646765266c6f676f3d70617970616c266c6f676f436f6c6f723d7768697465)](https://paypal.me/RongzhouChen) | [![Stripe](https://camo.githubusercontent.com/1152dfe04b6943afe3a8d2953676749603fb9f95e24088c92c97a01a897b4942/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5374726970652d446f6e6174652d3633354246463f7374796c653d666f722d7468652d6261646765266c6f676f3d737472697065266c6f676f436f6c6f723d7768697465)](https://buy.stripe.com/aFadR8gIaflgfQV6T4fw400) |

## Contact

- Site web : [lazying.art](https://lazying.art)
- GitHub : [lachlanchen](https://github.com/lachlanchen)
- Email : lach@lazying.art
