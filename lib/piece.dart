import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tetrisgame/values.dart';

import 'board.dart';

class Piece {
  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  //color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? const Color(0x00ffffff);
  }

  // generate the integers
  void initiatizePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;

      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;

      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    //new position
    List<int> newPosition = [];

    //rotate the peice based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*

              0
              0
              0 0

            */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before rotating
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

            0 0 0
            0

            */

            //assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

            0 0
              0
              0

          */

            //assign new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

                0
            0 0 0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*
             0
             0
           0 0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

            0
            0 0 0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

           0 0
           0
           0

          */

            //assign new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

           0 0 0
               0

          */

            //assign new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*

            0 0 0 0

          */

            //assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

            0
            0
            0
            0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

            0 0 0 0

          */

            //assign new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

              0
              0
              0
              0

          */

            //assign new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.O:
        /*
        the O tetromino does not need to be rotated
         */
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*

            0 0
          0 0

          */

            //assign new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

            0
            0 0
              0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

           0 0
         0 0

          */

            //assign new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

           0
           0 0
             0

          */

            //assign new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*

            0 0
              0 0

          */

            //assign new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

              0
            0 0
            0

          */

            //assign new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

            0 0
              0 0

          */

            //assign new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

           0 0
             0 0

          */

            //assign new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*

            0
            0 0
            0

          */

            //assign new position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*

            0 0 0
              0

          */

            //assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*

             0
           0 0
             0

          */

            //assign new position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*

             0
           0 0 0

          */

            //assign new position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update rotation
              position = newPosition;
              //update
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  //check if valid position before rotation
  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = (position % rowLength);

    // if th eposition is taken , return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      //get the col of position
      int col = pos % rowLength;

      //check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
