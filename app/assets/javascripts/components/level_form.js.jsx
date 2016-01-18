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
  newLevel: function() {
    if (this.state.name === '') { 
      alert('You need to add a title to your level');
      return false;
    }
    
    if (check_tile(2, 2)) {
      alert('This level isn\'t able to completed, fix the issues and try submitting again');
      return false;
    }
    this.refs.map.value = grid;
    this.refs.width.value = grid[0].length;
    return true;
  },
  render: function() {
    return (
      <form className='' method='post' action={'/games/' + this.props.token} onSubmit={this.newLevel} ref='game_form'>
        <a href='/' className='logo'>Circ</a>
        <div className='right'>
          <input type='text' name='game[name]' value={this.state.name} placeholder='Level Name' />
          <input type='hidden' name='game[map]' value={JSON.stringify(grid)} ref='map' />
          <input type='hidden' name='width' value={JSON.stringify(grid)} ref='width' />
          <input type='submit' value='Submit' />
        </div>
      </form>
    );
  }
});
