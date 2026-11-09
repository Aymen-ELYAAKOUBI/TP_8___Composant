# TP 8 : Gestion des Threads, Handlers et Traitements Asynchrones sous Android

Ce projet correspond au **TP 8** du module de développement d'applications Android. Il met en pratique la gestion de la concurrence, des threads en arrière-plan et des coroutines Kotlin pour éviter le blocage de l'interface utilisateur (ANR).

---

## 📋 Table des Matières
1. [Introduction et Objectifs (Exercice 1)](#-introduction-et-objectifs-exercice-1)
2. [Architecture et Implémentation](#-architecture-et-implémentation)
3. [Exercice 2 : Questions Théoriques et Réponses](#-exercice-2--questions-théoriques-et-réponses)
4. [Lancer le Projet](#-lancer-le-projet)

---

## 🎯 Introduction et Objectifs (Exercice 1)

Dans ce TP, nous avons exploré comment exécuter des tâches longues (simulations de calculs, compteurs, processus en arrière-plan) sans bloquer le **Main Thread** (fil d'exécution principal ou UI Thread).

### Fonctionnalités implémentées :
- **Thread + Handler** : Utilisation d'un `Thread` en arrière-plan combiné avec un `Handler(Looper.getMainLooper())` pour poster des mises à jour de progression sur le `ProgressBar` et le `TextView` de manière sécurisée.
- **Coroutines Kotlin** : Utilisation moderne et efficace de `lifecycleScope.launch`, `Dispatchers.IO` (pour les tâches lourdes en arrière-plan) et `Dispatchers.Main` (pour mettre à jour l'UI).
- **Simulation de Calcul Lourd** : Traitement intensif en arrière-plan avec indicateur de progression indéterminé pour garantir la fluidité de l'interface utilisateur.

---

## 🛠️ Architecture et Implémentation

### 1. Structure des Fichiers Clés
- **[MainActivity.kt](file:///C:/Users/user/AndroidStudioProjects/TP_8___Composant/app/src/main/java/com/example/tp_8___composant/MainActivity.kt)** : Contient la logique des boutons et la gestion des threads/coroutines.
- **[activity_main.xml](file:///C:/Users/user/AndroidStudioProjects/TP_8___Composant/app/src/main/res/layout/activity_main.xml)** : Interface utilisateur (Linear Layout avec TextView de statut, ProgressBar horizontale et boutons d'action).

### 2. Extrait de Code Clé (Coroutines vs Thread/Handler)

#### Approche Coroutines :
```kotlin
lifecycleScope.launch {
    withContext(Dispatchers.IO) {
        for (i in 1..10) {
            delay(300L)
            val progress = i * 10
            withContext(Dispatchers.Main) {
                progressBar.progress = progress
                tvStatus.text = "Progression (Coroutine) : $progress%"
            }
        }
    }
    tvStatus.text = "Tâche Coroutines terminée !"
}
```

---

## 🧠 Exercice 2 : Questions Théoriques et Réponses

### Q1 : Qu'est-ce que le "Main Thread" (ou UI Thread) dans Android et pourquoi ne doit-on pas y exécuter des tâches longues ?
**Réponse :** 
Le Main Thread est le fil d'exécution unique responsable de la création, du dessin et de la mise à jour des éléments visuels de l'interface (UI), ainsi que de la gestion des interactions utilisateur (clics, gestes). 
Il ne faut jamais y exécuter de tâches longues (accès réseau, requêtes de base de données, calculs complexes) car si le Main Thread est occupé pendant plus de 5 secondes, le système Android déclenche une erreur **ANR (Application Not Responding)** et force la fermeture de l'application.

### Q2 : Quelle est la différence entre un `Thread` classique et un `Handler` sous Android ?
**Réponse :**
- Un **Thread** (fil d'exécution) permet d'exécuter du code en parallèle en dehors du fil principal (en arrière-plan). Cependant, un Thread en arrière-plan **n'a pas le droit de modifier directement les éléments de l'UI** (comme les TextView ou ProgressBar), sous peine de lever une exception (`CalledFromWrongThreadException`).
- Un **Handler** est un mécanisme qui permet de communiquer entre un Thread d'arrière-plan et le Main Thread. En utilisant `Handler(Looper.getMainLooper()).post { ... }`, on demande au Handler de poster l'action de mise à jour de l'UI pour qu'elle s'exécute en toute sécurité sur le fil principal.

### Q3 : Pourquoi les Coroutines Kotlin sont-elles préférées aux Threads traditionnels dans le développement Android moderne ?
**Réponse :**
Les Coroutines sont souvent qualifiées de "threads légers" (*light-weight threads*). Contrairement aux Threads Java traditionnels :
1. **Économie de ressources** : De nombreuses coroutines peuvent partager un même pool de threads sans surcharger la mémoire (pas de création excessive de threads système).
2. **Lisibilité du code** : Grâce à la programmation séquentielle et aux fonctions de suspension (`suspend`), le code asynchrone s'écrit de manière linéaire sans imbrication complexe de callbacks.
3. **Gestion du cycle de vie** : Avec `lifecycleScope`, les coroutines sont automatiquement annulées lorsque l'activité est détruite, évitant ainsi les fuites de mémoire (*memory leaks*).

---

## 🚀 Lancer le Projet
1. Ouvrez le projet dans **Android Studio**.
2. Synchronisez Gradle (`Sync Project with Gradle Files`).
3. Lancez l'application sur un émulateur ou un appareil physique (Android 10+ / API 29+).
