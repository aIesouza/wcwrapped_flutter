# wcwrapped_flutter

Flutter version of your HTML/CSS/JS recap prototype.

## What to copy from the old project

Copy these folders from your current project into this Flutter project:

- `fonts/Inter-Bold.ttf` -> `assets/fonts/Inter-Bold.ttf`
- `fonts/DrukLCG-Bold.ttf` -> `assets/fonts/DrukLCG-Bold.ttf`
- everything inside `imgs/` -> `assets/images/`

### Important path rename
In Flutter, use paths like:

- `assets/images/page-1/profile.png`
- `assets/images/1F_icon.png`
- `assets/images/cards_star_bg.png`

So you should flatten your old `imgs` folder into `assets/images` while keeping the subfolders.

## Run the project

```bash
flutter pub get
flutter run
```

## Suggested next steps

1. Make sure every asset exists in the new folders.
2. Run `flutter pub get`.
3. Run `flutter run`.
4. Replace the placeholder story data in `lib/data/story_pages.dart` with real API data later.

## Folder overview

- `lib/main.dart` -> app entry point
- `lib/data/story_pages.dart` -> all placeholder data
- `lib/models/story_page_data.dart` -> data model
- `lib/screens/wrapped_story_screen.dart` -> main story experience
- `lib/widgets/` -> reusable UI pieces

## Nice thing about this version

The UI is split into reusable widgets, so later it will be much easier to connect real data from OneFootball.
