# Add support for command line arguments: board size, ant starting position
x = 50 
y = 50

row = [None] * x
board = [row] * y

ant = {
  x: 25,
  y: 25
}

round = 0 

def runNextRound(board, ant): 
  round += 1

  # Make this functional
  moveAnt(board, ant)

  # Print to screen
  # printRound(board, ant)  

  # Sleep?

def moveAnt(board, ant):
  '''
  If ant is on white, go left
    Flip color
  If ant is on black, go right
    Flip color
  If ant can't go intended direction, end game
  '''
  print (ant)

def printRound(board, ant):
  print(ant)