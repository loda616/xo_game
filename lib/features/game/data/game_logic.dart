class GameLogic {
  List<String?> board = List.generate(9, (_) => null);
  bool isXTurn = true;

  void resetGame() {
    board = List.generate(9, (_) => null);
    isXTurn = true;
  }

  bool makeMove(int index) {
    if (board[index] == null) {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
      return true;
    }
    return false;
  }

  String? checkWinner() {
    const winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      final a = combo[0], b = combo[1], c = combo[2];
      if (board[a] != null && board[a] == board[b] && board[a] == board[c]) {
        return board[a]; // Returns "X" or "O"
      }
    }

    if (board.every((element) => element != null)) {
      return 'Draw'; // Game is a draw if all spaces are filled
    }

    return null; // Game continues if there's no winner yet
  }
}
