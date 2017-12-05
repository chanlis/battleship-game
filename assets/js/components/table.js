import React from 'react';
import ReactDOM from 'react-dom';

// Board inspired by: https://jsfiddle.net/mrlew/cLbyyL27/

class Cell extends React.Component {
  constructor(props) {
    super(props);
    this.state = {selected: false};
  }
  
  onClick(e) {
    this.setState({ 
      selected: true 
    });
  }
  
  render() {
    return ( 
      <div className="board-cell" onClick={this.onClick.bind(this)}>
        <span className="board-cell-content">
          {this.state.selected ? "X" : null}
        </span>
      </div>
    );
  }
}   

export default class Table extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.props.state;
  }

  render() {
    let player = this.props.player;
    if (player == 1) {
      player = this.props.state.player1;
    } else {
      player = this.props.state.player2;
    }
    return (
      <div className="col text-center p-2">
        <p className="text-center">{player.name}</p>
        <div className="board">
          {[0,1,2,3,4,5,6,7,8,9].map((y) => {
            return (
              <div key={y} className="board-row">
                {[0,1,2,3,4,5,6,7,8,9].map((x) => {
                  return <Cell key={x} x={x} y={y}></Cell>
                })}
              </div>
            )})}
        </div>
      </div>
    );
  }
}
