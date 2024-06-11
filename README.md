# 2048 Game in Racket

![GitHub stars](https://img.shields.io/github/stars/nagan319/2048-LISP?style=social)
![GitHub forks](https://img.shields.io/github/forks/nagan319/2048-LISP?style=social)
![GitHub license](https://img.shields.io/github/license/nagan319/2048-LISP)

This is an implementation of the 2048 game in Racket, a dialect of Lisp. Feel free to play around!

## Getting Started

### Prerequisites

- [Racket](https://racket-lang.org/) (Make sure Racket is installed on your system)

### Running the Game

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/2048-racket.git
    ```
2. Navigate to the project directory:
    ```sh
    cd 2048-racket
    ```
3. Run the game:
    ```sh
    racket main.rkt
    ```

## How to Play

1. Use the command line to input your moves:
    - `w`: Move tiles up
    - `a`: Move tiles left
    - `s`: Move tiles down
    - `d`: Move tiles right
2. The game will print the board and your score after each move.
3. Combine tiles of the same number to create larger numbers.
4. The game ends when no more moves are possible.

### Functions

- `append`: Appends two lists.
- `reverse`: Reverses a list.
- `len`: Returns the length of a list.
- `index`: Retrieves an element at a specified index in a list.
- `flatten`: Flattens a 2D board into a 1D list.
- `unflatten`: Converts a 1D list back into a 2D board.
- `game-over`: Prints the game over message and the score.
- `print`: Prints the current state of the board and the score.
- `new-num`: Adds a new number (2) to a random empty spot on the board.
- `player-move`: Handles the player's move, combines tiles, and updates the board and score.
- `main`: The main game loop that initializes the board, handles moves, and checks for game over conditions.
