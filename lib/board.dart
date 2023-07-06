import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetrisgame/piece.dart';
import 'package:tetrisgame/pixel.dart';
import 'package:tetrisgame/values.dart';

// GAME BOARD
// This is a 2x2 grid with null representing an empty space.
// A non empty space will have the color to represent the landed pieces

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
); // List.generate

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  //current score
  int currentScore = 0;

  //game over status
  bool gameOver = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initiatizePiece();

    //frameRefresh rate
    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  //game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //clear lines
        clearLines();

        //check landing
        checkLanding();

        //check if game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        //move current piece
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    //loop through each position of current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the roe and column
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      //adjust the row and col based on direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is out of bounds (either too low or too far to the left or right)
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    //if no coliision is detected
    return false;
  }

  //check Landing
  void checkLanding() {
    // if going down is occupied or landed on other pieces
    if (checkCollision(Direction.down) || checkLanded()) {
      // mark position as occupied on the game board
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void createNewPiece() {
    //create a random obejct to generate random tetromino types
    Random rand = Random();

    //create a piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initiatizePiece();

    /*

    Since our game over condition ts if there iS a piece at the top level,
you want to check if the game over when you create a new piece
instead ot cttecktng every frame, because new pieces are allowed to go throu the top levet
but if there IS already a pxece in the top level when the new piece is created.
then game is over

     */

    if (isGameOver()) {
      gameOver = true;
    }
  }

  //left
  moveLeft() {
    //make sure the move is value before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //right
  moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  //rotate
  rotate() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //clear lines
  clearLines() {
    //step 1: loop through each row of the game boord form bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      //step3: Check if the row is full
      for (int col = 0; col < rowLength; col++) {
        //if there is an empty column, set rowIsFull=false
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      //step4: if the row is full, clear the row and shift the rows down;
      if (rowIsFull) {
        //step5: move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        //step6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        //step7: increase the score!
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    //check if any columns in the top row is filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                //get row and col of each index
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                    child: index,
                  );
                }

                //landed piece
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                      color: tetrominoColors[tetrominoType], child: '');
                }

                //blank piece
                else {
                  return Pixel(
                    color: Colors.grey[900],
                    child: index,
                  );
                }
              },
            ),
          ),

          //Score
          Text(
            'Score: $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          //Game Controllers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // left
              IconButton(
                  onPressed: moveLeft,
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white),

              //rotate
              IconButton(
                  onPressed: rotate,
                  icon: const Icon(Icons.rotate_right),
                  color: Colors.white),

              //right
              IconButton(
                  onPressed: moveRight,
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }

  showGameOverDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('Game Over'),
              content: Text('Your Score is: $currentScore'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      //reset game method
                      resetGame();
                      Navigator.pop(context);
                    },
                    child: const Text('Play Again'))
              ],
            ),
          );
        });
  }

  resetGame() {
//clear the game board
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    //new game
    gameOver = false;
    currentScore = 0;

    //create new piece
    createNewPiece();

    //start the game
    startGame();
  }
}
