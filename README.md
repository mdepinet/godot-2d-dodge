This repository contains a simple 2D game created in the [Godot](https://github.com/godotengine/godot) engine (version 4.1).
The game is based on [Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html), with a few extra features:

* The map is toroidal instead of rectangular - players can wrap around from the left to right and top to bottom
* Enemies won't spawn too close to the player
* The difficulty has been modified to start easy and get progressively harder
* A locally-persisted leaderboard was added
    + Players can enter their initials when the get a high score
    + The leaderboard is shown on changes and is accessible from the main menu
    + The leaderboard is persisted between application runs
* Controller support added
* Players can "sprint" to increase their speed
