import time
import sys

'''
TODO
- Update board in place when printing instead of printing a new board every time
'''

x = int(sys.argv[1]) if len(sys.argv) >= 3 else 20
y = int(sys.argv[2]) if len(sys.argv) >= 3 else 20

def create_board(x, y):
  board = []

  for i in range(y):
    board.append([False] * x)

  return board

board = create_board(x, y)

ant = {
  'x': round(x / 2),
  'y': round(y / 2),
  'orientation': 'n'
}

clockwise_orientation_map = {
  'n': 'e',
  'e': 's',
  's': 'w',
  'w': 'n'
}

counter_clockwise_orientation_map = {
  'n': 'w',
  'w': 's',
  's': 'e',
  'e': 'n'
}

def run_next_round(board, ant, round = 0):
  round += 1
  print(f'-------------{round}------------------')

  (board, ant, game_over) = update_board(board, ant)

  if game_over:
    print(f'Game over after {round} rounds')
    return

  print_round(board, ant)

  time.sleep(0.5)

  run_next_round(board, ant, round)

def update_current_tile(board, ant, current_board_value):
  board[ant['y']][ant['x']] = not current_board_value

def reorient_ant(current_board_value, ant):
  direction = None

  if current_board_value:
    direction = clockwise_orientation_map
  else:
    direction = counter_clockwise_orientation_map

  ant['orientation'] = direction[ant['orientation']]

def move_ant(ant):
  if ant['orientation'] == 'n':
    ant['y'] += 1
  elif ant['orientation'] == 'e':
    ant['x'] += 1
  elif ant['orientation'] == 's':
    ant['y'] -= 1
  else:
    ant['x'] -= 1


def check_is_game_over(ant):
  return ant['x'] < 0 or ant['x'] == x or ant['y'] < 0 or ant['y'] == y

def update_board(board, ant):
  current_board_value = board[ant['y']][ant['x']]

  update_current_tile(board, ant, current_board_value)

  reorient_ant(current_board_value, ant)

  move_ant(ant)

  is_game_over = check_is_game_over(ant)

  return (board, ant, is_game_over)

def print_round(board, ant):
  for i in range(len(board)):
    row = []

    for j in range(len(board[i])):
      if ant['y'] == i and ant['x'] == j:
        row.append('X')
      elif board[i][j]:
        row.append('+')
      else:
        row.append('-')

    print(row)

run_next_round(board, ant)