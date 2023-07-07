import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showGameOverDialog(context,currentScore, resetGame){

  return showDialog(
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