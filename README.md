# Mad Animals

## Summary
**Mad Animals** is an engaging 2D physics-based game inspired by the popular "Angry Birds." In this game, players must launch birds with the goal of landing them in cups placed around the scene. Each level presents a unique challenge, requiring players to aim and adjust the force of their launches to succeed.

Developed using Godot 4.2, **Mad Animals** highlights RigidBodies, the Godot physics engine, and data persistence for saving scores.

You can try the game on [itch.io](https://lcsilva.itch.io/madanimals)!

## Features
- **Physics-based gameplay:** Utilizes Godot's physics engine to create realistic movements and interactions.
- **Challenging levels:** Three levels, each with its to cups to aim for.
- **Scoring system:** Earn points based on the number of cups successfully hit (maximum score per level = number of cups * 1000 - number of cups * 2).
- **Score saving:** Persists the highest score for each level on the user's disk.
- **Simple controls:** Click and drag to aim, release to launch the bird.

## How to Play
- Click and drag to aim the bird.
- Adjust the launch angle and force by moving the mouse.
- Release the mouse button to launch the bird.
- Try to land the bird in the cups to score points.
- Each cup is worth 1000 points.
- Complete all three levels to see your total score.

## Future Improvements
- **Additional Levels:** Add more levels to increase the variety and challenge.
- **Additional Components:** Add obstacules to the levels from which the player can collide from, like walls or moving cups.
- **Enhanced Graphics:** Improve the visual style and animations for a more engaging experience.
- **Power-ups:** Introduce power-ups to provide unique abilities and enhance gameplay.

## What I've Learned

### 1. Basics of Godot Engine
- **Introduction to Godot 4.2:** Gained an understanding of the Godot interface, scene system, inherited scenes and the node-based structure.
- **Creating a 2D Scene:** Set up the game scene, including backgrounds, birds, and cups.

### 2. Game Mechanics
- **RigidBodies:** Implemented RigidBodies for the birds to enable realistic physics interactions.
- **Physics Engine:** Utilized Godot's physics engine to handle collisions, gravity, and other physical properties.

### 3. Game Logic
- **Level Design:** Designed three levels with varying challenges and cup placements.
- **Scoring System:** Developed a scoring system where each cup is worth 1000 points, and the maximum score per level is calculated based on the number of cups subtracted by the amount of attemps times 2! (3 cups => highest possible score is 2994, one try per cup)

### 4. UI and UX
- **User Interface:** Designed a basic UI to display the current score and the highest score for each level.
- **Level Selection Screen:** Created a level selection screen to allow players to choose which level to play.

### 5. Data Persistence
- **Saving Scores:** Implemented functionality to save and retrieve the highest score for each level from the user's disk.

## Acknowledgments
This game was developed as part of the Udemy course "Jumpstart to 2D Game Development: Godot 4 for Beginners." Special thanks to the course instructor for providing comprehensive tutorials and guidance throughout the development process.

---

Enjoy playing **Mad Animals** and see if you can land all the birds in the cups! Try it out now on [itch.io](https://lcsilva.itch.io/madanimals)!