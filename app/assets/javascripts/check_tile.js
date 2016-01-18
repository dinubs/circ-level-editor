var curr_x = 2;
var curr_y = 2;
var found_end = false;
var checked = [];
var time = 0;

var tiles_to_check = [true, true, false, false, true, false, false];
var end_index = 6;
var prev_direction = '';
var prev_direction_times = 0;

function check_tile(x, y) {
  var current_tile = grid[y][x];
  console.log(x, y);
  if (current_tile === end_index) return true;
  if (!tiles_to_check[current_tile]) return false;
  if (checked.indexOf(x + '' + y) > -1) return false;
  checked.push(x + '' + y);

  if (check_tile(x+1, y)) return true;
  if (check_tile(x-1, y)) return true;
  if (check_tile(x, y-1)) return true;
  if (check_tile(x, y+1)) return true;
  return false
}