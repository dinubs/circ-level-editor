var w = 25;
var h = 25;
var tiles = [
  {"colour": "#333"}, // BG tile
  {"colour": "#888"}, // Air tile
  {"colour": "#555"}, // Floor tile
  {"colour": "#C93232"}, // Lava tile
  {"colour": "rgba(121, 220, 242, 0.4)"}, // Water tile
  {"colour": "#E373FA"}, // Bounce block
  {"colour": "#ffc61e"} // Finish tile
];
var start = {
  "x": 2,
  "y": 2
};

var current_tile = 1;

var grid = window.grid = [[2,2,2,2,2,2,2,2,2,2],
            [2,1,1,1,1,1,1,1,1,2],
            [2,1,1,1,1,1,1,1,1,2],
            [2,1,1,1,1,1,1,1,1,2],
            [2,2,2,2,2,2,2,2,2,2]];

var Pixel = React.createClass({
  updateGrid: function() {
    var y = this.props.y;
    var x = this.props.x;

    if (x === start.x && y === start.y) {
      return;
    }
    
    grid[y][x] = current_tile;
    this.props.reRender();
  },
  render: function() {
    var style = {
      backgroundColor: tiles[this.props.tile].colour
    };
    if (this.props.x === start.x && this.props.y === start.y) style.border = '1px solid #ffc61e';
    
    return (
      <div onClick={this.updateGrid} className='level__pixel' style={style}></div>
    );
  }
});

var TilePicker = React.createClass({
  set_tile: function(index) {
    current_tile = index;
  },
  render: function() {
    var tile_icons = tiles.map(function(tile, index) {
      var style = {
        backgroundColor: tile.colour
      };
      return (
        <div className='level__tile_chooser__tile' style={style} onClick={this.set_tile.bind(this, index)}></div>
      );
    }.bind(this));
    return (
      <div className='level__tile_chooser'>
        {tile_icons}
      </div>
      );
  }
});

var LevelEditor = React.createClass({
  reRender: function() {
    this.forceUpdate();
  },
  add: function(type) {
    if (type === 'column') {
      grid.forEach(function(row) {
        row.push(2);
      });
    } else {
      var array_copy = grid[grid.length - 1].slice(0);
      grid.push(array_copy);
    }
    this.forceUpdate();
  },
  remove: function(type) {
    if (type === 'column') {
      grid.forEach(function(row) {
        row.pop();
      });
    } else {
      grid.pop();
    }
    this.forceUpdate();
  },
  renderPixels: function() {
    var pixels = [];
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid[y].length; x++) {        
        pixels.push(<Pixel tile={grid[y][x]} x={x} y={y} reRender={this.reRender} />);
      }   
    }
    return pixels;
  },
  render: function() {
    var width = grid[0].length * 25 + (2 * grid[0].length);
    var style = {
      width: width
    };
    width = grid.length * 25 + (2 * grid.length - 2);
    var add_column_style = {
      width: width
    }
    return (
      <div>
        <div style={style}>
          <TilePicker />  
          {this.renderPixels()} 
          <div style={add_column_style} className='level__add--column' onClick={this.add.bind(this, 'column')}>+1 Col</div>
          <div className='level__add--row' onClick={this.add.bind(this, 'row')}>+1 Row</div>
          <div style={add_column_style} className='level__remove--column' onClick={this.remove.bind(this, 'column')}>-1 Col</div>
          <div className='level__remove--row' onClick={this.remove.bind(this, 'row')}>-1 Row</div>      
        </div>
      </div>
    );
  }
});