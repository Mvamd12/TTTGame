import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;
  bool gameWon;

  TicTacToe() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
    gameWon = false;
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int position) {
    int row = (position - 1) ~/ 3;
    int col = (position - 1) % 3;

    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      return true;
    } else {
      print('Cell already occupied. Please choose a different position.');
      return false;
    }
  }

  bool checkWin() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        return true; // Row win
      }
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer) {
        return true; // Column win
      }
    }

    // Check diagonals
    if (board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true; // Diagonal win
    }
    if (board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true; // Diagonal win
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains(' ')) {
        return false;
      }
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    int move;
    do {
      printBoard();
      print('Player $currentPlayer, enter your move (1-9): ');
      move = int.tryParse(stdin.readLineSync()!);

      if (move != null && move >= 1 && move <= 9) {
        if (makeMove(move)) {
          gameWon = checkWin();
          if (!gameWon) {
            if (isBoardFull()) {
              printBoard();
              print('The game is a draw!');
              return;
            }
            switchPlayer();
          }
        }
      } else {
        print('Invalid input. Please enter a number between 1 and 9.');
      }
    } while (!gameWon);
    printBoard();
    print('Player $currentPlayer wins!');
  }
}

void main() {
  print('Welcome to Tic-Tac-Toe!');
  print('Player 1, choose your marker (X or O): ');

  String marker = stdin.readLineSync()!.toUpperCase();
  if (marker != 'X' && marker != 'O') {
    print('Invalid marker. Defaulting to X.');
    marker = 'X';
  }

  TicTacToe game = TicTacToe();
  game.currentPlayer = marker;

  do {
    game.play();
    print('Do you want to play again? (yes/no): ');
  } while (stdin.readLineSync()!.toLowerCase() == 'yes');
}
