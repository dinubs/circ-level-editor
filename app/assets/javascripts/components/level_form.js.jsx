var LevelForm = React.createClass({
  getInitialState: function() {
    return {
      name: this.props.name
    }
  },
  componentDidMount: function() {
  },
  propTypes: {
    name: React.PropTypes.string,
    map: React.PropTypes.string
  },
  newLevel: function(e) {
    if (!this.refs.name.value) { 
      alert('You need to add a title to your level ' + this.refs.name.value);
      e.preventDefault();
    }
    
    if (!check_tile(2, 2)) {
      alert('This level isn\'t able to completed, fix the issues and try submitting again');
      e.preventDefault();
    }
    checked = [];
    
    this.refs.map.value = grid;
    this.refs.width.value = grid[0].length;
    return true;
  },
  render: function() {
    return (
      <form className='' method='post' action={'/games/' + this.props.token} onSubmit={this.newLevel.bind(this)} ref='game_form'>
        <a href='/' className='logo'>Circ</a>
        <div className='right'>
          <input type='text' name='game[name]' value={this.props.name} placeholder='Level Name' ref='game_name' />
          <input type='hidden' name='game[map]' value={JSON.stringify(grid)} ref='map' />
          <input type='hidden' name='width' value={JSON.stringify(grid)} ref='width' />
          <input type='submit' value='Submit' />
        </div>
      </form>
    );
  }
});
