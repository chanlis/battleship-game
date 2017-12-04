import React from 'react';
import ReactDOM from 'react-dom';

class Square extends React.Component {
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
  render() {
    return (
      <div className="board">
        {[0,1,2,3,4,5,6,7,8,9].map((y) => {
	  return (
            <div key={y} className="board-row">
              {[0,1,2,3,4,5,6,7,8,9].map((x) => {
                return <Square key={x} x={x} y={y}></Square>
              })}
            </div>
          )})}
      </div>
    );
  }
}
