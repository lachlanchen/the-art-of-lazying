[English](../README.md) · [العربية](README.ar.md) · [Español](README.es.md) · [Français](README.fr.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Tiếng Việt](README.vi.md) · [中文 (简体)](README.zh-Hans.md) · [中文（繁體）](README.zh-Hant.md) · [Deutsch](README.de.md) · [Русский](README.ru.md)


<p align="center">
  <img src="https://raw.githubusercontent.com/lachlanchen/lachlanchen/main/logos/banner.png" alt="LazyingArt banner" />
</p>

# The Art of Lazying

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-%23ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/lachlanchen)
[![Website](https://img.shields.io/badge/Website-lazying.art-0a7ea4)](https://lazying.art)
![Docs](https://img.shields.io/badge/Docs-Multilingual-1f883d)
![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)

Un dépôt centré sur la paresse stratégique pour une vie plus simple et à plus fort effet de levier, couvrant les agents IA, l'apprentissage des langues, l'automatisation pratique et des workflows réels pilotés par des vlogs.

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
- [La théorie du Lazying](#la-théorie-du-lazying)
- [Conseils et astuces pratiques](#conseils-et-astuces-pratiques)
- [Cas d'usage](#cas-dusage)
- [Agents IA et automatisation](#agents-ia-et-automatisation)
- [Apprentissage des langues et vlogs](#apprentissage-des-langues-et-vlogs)
- [Contributions de la communauté](#contributions-de-la-communauté)
- [Contact](#contact)
- [Support / Donation](#support--donation)
- [Contribuer](#contribuer)
- [Licence](#licence)

## Vue d'ensemble

`the-art-of-lazying` est un dépôt hub pour la paresse stratégique appliquée: automatiser les tâches répétitives, améliorer les workflows d'apprentissage des langues et documenter des expérimentations réelles via des scripts et des vlogs.

| En bref | Détails |
|---|---|
| 🎯 Thème central | Paresse stratégique pour la productivité, l'apprentissage et la création |
| 🧩 Style du dépôt | Hybride entre outils locaux et projets externes sélectionnés |
| 🛠️ Points forts locaux | `code/EinkWordsGPT`, `scripts/lazy-care/SafeShell`, `vlogs/chatgpt-traffic`, `vlogs/repo2text` |
| 🌍 Documentation | README racine + variantes multilingues dans `i18n/` |

Ce dépôt contient à la fois:
- Des liens sélectionnés vers des projets externes connexes.
- Des outils et du code locaux, en particulier:
  - `code/EinkWordsGPT` (Raspberry Pi + e-ink Waveshare + affichage d'apprentissage de mots avec OpenAI).
  - `scripts/lazy-care/SafeShell` (fonctions shell de suppression/restauration sécurisées).
  - `vlogs/chatgpt-traffic` et `vlogs/repo2text` (petits utilitaires Python).

## Projets

### 🚀 Outils créatifs propulsés par l'IA

| Projet | Description | Démo |
|---------|-------------|------|
| [EinkWordsGPT](https://github.com/lachlanchen/the-art-of-lazying/tree/main/code/EinkWordsGPT) | Écran e-ink avec apprentissage de mots piloté par GPT | ![WordsOrigin](demos/words_card_arabic.JPG) |
| [WordsOrigin](https://github.com/lachlanchen/WordOrigins) | Analyse de l'origine des mots et visualisation en graphe. | ![WordsOrigin](demos/words_origin.jpg) |
| [LazyLanguageLearner](https://github.com/lachlanchen/lazylanguagelearner) | Outils pour un apprentissage efficace des langues avec un effort minimal | |
| [VideoCaptionerWithClip](https://github.com/lachlanchen/VideoCaptionerWithClip) | Sous-titrage vidéo et image avec embeddings OpenAI CLIP + décodeur GPT | ![AutoCaption](demos/autocaption.PNG) |
| [VideoCaptionerWithVit](https://github.com/lachlanchen/VideoCaptionerWithVit) | Outil de sous-titrage vidéo: extraction de keyframes avec Katna/OpenCV et génération de légendes via un modèle ViT+GPT-2 | |
| [AutoTranscription - MultilingualWhisper](https://github.com/lachlanchen/MultilingualWhisper) | Pipeline de transcription multilingue avec détection fine de la langue | ![AutoTranscription](demos/autotranscription.PNG) |
| [**AutoTranslation**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_translate.py) | Briser les barrières linguistiques pour des échanges créatifs mondiaux | ![AutoTranslation](demos/autotranslation.JPG) |
| [**AutoMeta**](https://github.com/lachlanchen/LazyEdit/blob/master/lazyedit/subtitle_metadata.py) | Génération automatique de métadonnées vidéo | |
| [LazyEdit](https://github.com/lachlanchen/LazyEdit) | Outil d'édition vidéo automatique propulsé par l'IA avec transcription, sous-titres automatiques, mise en avant et génération de métadonnées | |
| [AutoPublication](https://github.com/lachlanchen/AutoPublication) | Rationalisation des workflows de publication de contenu | ![AutoPublication](demos/autopublication.png) |
| [AutoPubMonitor](https://github.com/lachlanchen/AutoPubMonitor) | Système automatisé de suivi, traitement et publication de contenus vidéo vers plusieurs plateformes | |
| [Grilling ChatGPT](https://github.com/lachlanchen/grilling_chatgpt) | Techniques avancées pour utiliser efficacement les assistants IA | |

### ⚙️ Outils d'automatisation (locaux dans ce dépôt)

- `scripts/lazy-care/SafeShell/safeshell_functions.sh`: suppression shell plus sûre (`saferm`), restauration (`unrm`) et suppression permanente explicite (`removeitanyway`).
- `vlogs/chatgpt-traffic/chatgpt-traffic.py`: résolveur domaine-vers-IP et générateur de sortie dédupliquée.
- `vlogs/repo2text/convert-repo-to-merged-text.py`: fusionne les fichiers Python par dossier en bundles texte pour l'analyse assistée par IA.

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

Remarque: d'anciens schémas génériques de dossiers dans des variantes README précédentes faisaient référence à des chemins abstraits (par exemple `book/`, `code/ai-agents/`) qui ne correspondent pas exactement à l'arborescence actuelle. La structure ci-dessus reflète les fichiers actuels.

## Fonctionnalités

- Cadre de paresse stratégique pour la productivité, l'apprentissage et les workflows de contenu.
- Portefeuille de projets IA sélectionnés couvrant transcription, sous-titrage, traduction et automatisation de publication.
- Apprentissage des langues intégré au matériel avec sélection de mots assistée par GPT (`EinkWordsGPT`).
- Outils shell pratiques de sécurité pour des workflows de suppression réversible.
- Utilitaires orientés scripts pour vérification DNS/trafic de domaines et conversion dépôt-vers-texte.
- Prise en charge de la documentation multilingue via `i18n/`.

## Prérequis

Général:
- Git
- Python 3.9+ recommandé

Pour `code/EinkWordsGPT`:
- Raspberry Pi (la documentation du projet mentionne Raspberry Pi 5)
- Écran e-ink Waveshare 7,3 pouces 7 couleurs avec prise en charge du driver Python (`waveshare_epd`)
- Packages Python utilisés dans le code: `openai`, `Pillow`, `pytz`, `pykakasi`
- SQLite (la bibliothèque standard Python `sqlite3` est utilisée)
- Clé API OpenAI configurée dans l'environnement (le code initialise `OpenAI()` directement)

Pour `vlogs/chatgpt-traffic`:
- `dnspython`

Pour `scripts/lazy-care/SafeShell`:
- Shell Bash ou Zsh avec accès à `realpath`, `mv` et `/bin/rm`

## Installation

Clone the repository:

```bash
git clone https://github.com/lachlanchen/the-art-of-lazying.git
cd the-art-of-lazying
```

Install commonly used Python dependencies (repository-wide baseline):

```bash
pip install openai Pillow pytz pykakasi dnspython
```

Remarque: `code/EinkWordsGPT/README.md` mentionne `requirements.txt`, mais aucun `requirements.txt` n'est actuellement présent dans ce dépôt. Installez les packages manuellement comme ci-dessus.

## Utilisation

### 1) EinkWordsGPT (flux matériel local)

```bash
cd code/EinkWordsGPT
python epd_7in3f_test.py   # optional hardware/display test
python words_gpt.py        # run the display loop (refreshes approximately every 300s)
```

Script optionnel de maintenance de base de données:

```bash
cd code/EinkWordsGPT
python words_update.py
```

### 2) SafeShell (workflow de suppression plus sûr)

Chargez les fonctions shell:

```bash
cd scripts/lazy-care/SafeShell
cat safeshell_functions.sh >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                          # or source ~/.zshrc
```

Utilisez les commandes:

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

Remarque: `convert-repo-to-merged-text.py` utilise actuellement des chemins codés en dur (`source_directory = 'diffraction'`, `target_directory = 'merged_py_files'`). Modifiez ces constantes avant d'exécuter le script sur un autre dépôt.

## Configuration

### Configuration OpenAI (`code/EinkWordsGPT`)

Le code crée le client avec:

```python
client = OpenAI()
```

Configurez donc vos identifiants API avec l'approche standard des variables d'environnement OpenAI avant d'exécuter les scripts.

### Chemin de la base de données (`code/EinkWordsGPT`)

Valeur par défaut dans le code:

```python
db_path = 'words_phonetics.db'
```

Assurez-vous que `words_phonetics.db` existe dans `code/EinkWordsGPT/` (il est actuellement inclus dans ce dépôt).

### Emplacement de corbeille SafeShell

`saferm`/`unrm`/`removeitanyway` utilisent un chemin de base fixe:

```bash
/mnt/disk/BIN/ROOT
```

Ajustez ce chemin dans `scripts/lazy-care/SafeShell/safeshell_functions.sh` si votre environnement diffère.

## Exemples

- Démos de cartes de mots e-ink dans `demos/`:
  - `demos/words_card_arabic.JPG`
  - `demos/words_origin.jpg`
  - `demos/autocaption.PNG`
  - `demos/autotranscription.PNG`
  - `demos/autotranslation.JPG`
  - `demos/autopublication.png`
- Notes/matériaux de construction pour ChachaGPT:
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/plain_transformer.ipynb`
  - `examples/lazy-learning/BuildChachaGPTWithChatGPT/Prompts of ChachaGPT.pdf`

## Notes de développement

- Il s'agit d'un dépôt vitrine multi-projets avec à la fois du code local et des liens vers des projets externes.
- Aucun gestionnaire de paquets ou manifeste de build au niveau racine n'est actuellement fourni (`pyproject.toml`, `package.json`, `requirements.txt`, `Makefile` ne sont pas présents à la racine).
- Plusieurs sous-README sont de type template et peuvent être partiellement obsolètes par rapport à l'arborescence actuelle; les commandes de ce README sont alignées sur les chemins/scripts actuellement existants.
- `README_EN.md` et `README_CN.md` existent comme variantes historiques; `README.md` + `i18n/*` est la structure multilingue active.

## Dépannage

- `ModuleNotFoundError` pour des packages Python:
  - Réinstallez les dépendances avec `pip install openai Pillow pytz pykakasi dnspython`.

- `ImportError: waveshare_epd` dans `EinkWordsGPT`:
  - Installez le driver/bibliothèque Python Waveshare e-paper dans votre environnement Raspberry Pi.

- Erreurs d'authentification OpenAI:
  - Vérifiez que votre clé API OpenAI est définie dans les variables d'environnement avant d'exécuter `words_gpt.py` ou `words_update.py`.

- `saferm`/`unrm` introuvables après configuration:
  - Confirmez que vous avez sourcé le bon fichier rc shell et ajouté `safeshell_functions.sh` correctement.

- `unrm` ne peut pas restaurer des fichiers:
  - Vérifiez que votre chemin de restauration correspond à la structure miroir de corbeille SafeShell sous `/mnt/disk/BIN/ROOT`.

- Le script `repo2text` ne crée aucune sortie:
  - Mettez à jour `source_directory` dans `convert-repo-to-merged-text.py` vers un dossier existant.

## Feuille de route

- Étendre la parité du README racine à tous les fichiers i18n (actuellement résumés dans de nombreuses langues).
- Ajouter une documentation de configuration spécifique à l'environnement pour les drivers e-ink Waveshare.
- Ajouter des manifestes de dépendances reproductibles au niveau racine pour les outils locaux.
- Ajouter des scripts de validation/test pour les utilitaires critiques.
- Continuer à consolider les liens vers des projets externes avec des démos locales plus riches.

## Introduction

The Art of Lazying présente la paresse stratégique comme un moyen d'optimiser l'énergie et de se concentrer sur ce qui compte vraiment. Ce dépôt explore comment une paresse intentionnelle peut conduire à une productivité, une créativité et un bien-être supérieurs.

## La théorie du Lazying

Une introduction complète aux principes de la paresse stratégique, axée sur la maximisation de la productivité et du bien-être par la priorisation, la délégation et l'automatisation des tâches.

Le principe clé est d'appliquer la règle des 80/20 de Pareto à la vie quotidienne: identifier les 20 % d'activités qui produisent 80 % des résultats souhaités.

## Conseils et astuces pratiques

Une collection de conseils actionnables sur l'application des principes de la paresse au travail, aux relations et à l'auto-soin:
- Automatiser les tâches répétitives
- Utiliser la technique Pomodoro pour la gestion du temps
- Créer des systèmes qui réduisent la fatigue décisionnelle
- Exploiter des outils IA pour l'assistance

## Cas d'usage

Des exemples concrets montrant comment les principes du lazying résolvent des problèmes et améliorent l'efficacité:
- Comment les entrepreneurs utilisent la délégation et l'automatisation pour se concentrer sur la croissance de leur activité
- Comment les universitaires rationalisent leurs workflows de recherche
- Comment les créateurs de contenu optimisent leur processus de production

## Agents IA et automatisation

Explorez le développement d'agents IA et d'outils d'automatisation qui simplifient les tâches:
- Utiliser ChatGPT comme assistant personnel
- Construire des workflows d'automatisation personnalisés
- Créer des écrans e-ink pour l'apprentissage passif

## Apprentissage des langues et vlogs

Ressources et techniques pour un apprentissage efficace des langues, ainsi que des vlogs documentant le parcours lazying:
- Créer un apprentissage personnalisé des langues avec répétition espacée
- Mettre en œuvre des techniques d'apprentissage immersif
- Construire des projets qui encouragent l'apprentissage passif

## Contributions de la communauté

Partagez vos propres expériences, conseils et idées sur la paresse stratégique:
- Forum d'échange d'astuces de productivité
- Outils et modèles pour les routines quotidiennes
- Projets collaboratifs pour une efficacité "lazy"

## Contact

- Website: [lazying.art](https://lazying.art)
- GitHub: [lachlanchen](https://github.com/lachlanchen)
- Email: lach@lazying.art

---

## Support / Donation

<div align="center">
<table style="margin:0 auto; text-align:center; border-collapse:collapse;">
  <tr>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate">https://chat.lazying.art/donate</a>
    </td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;">
      <a href="https://chat.lazying.art/donate"><img src="figs/donate_button.svg" alt="Donate" height="44"></a>
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
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="WeChat QR" src="figs/donate_wechat.png" width="240"/></td>
    <td style="text-align:center; vertical-align:middle; padding:6px 12px;"><img alt="Alipay QR" src="figs/donate_alipay.png" width="240"/></td>
  </tr>
</table>
</div>

Liens de financement additionnels depuis `.github/FUNDING.yml`:
- GitHub Sponsors: https://github.com/sponsors/lachlanchen
- chat.lazying.art: https://chat.lazying.art
- onlyideas.art: https://onlyideas.art

## Contribuer

Les contributions sont bienvenues sur le code, la documentation, les exemples et les traductions.

1. Forkez le dépôt.
2. Créez une branche (`git checkout -b feature/your-feature`).
3. Apportez vos modifications avec des messages de commit clairs.
4. Ouvrez une Pull Request décrivant la motivation et l'impact.

Si vous ne savez pas par où commencer:
- Améliorer la documentation de configuration d'un outil local.
- Ajouter des tests ou scripts de validation pour les utilitaires existants.
- Améliorer la parité/qualité d'une variante `i18n/README.*.md`.

## Licence

Ce dépôt inclut le texte de licence GPLv3 à la racine (`LICENSE`) et dans plusieurs sous-dossiers.

Remarque: certains README de sous-projets mentionnent MIT. Tant que chaque sous-module n'est pas clarifié, considérez le dépôt racine comme régi par GPLv3 et vérifiez par sous-projet si vous prévoyez de redistribuer du code indépendamment.
