import React from 'react';
import Chat from './chat';
import Table from './table';

export default class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = this.props.state;
    this.props.channel.on("state_update", s => this.updateState(s));
  };

  updateState(s) {
    this.setState(s);
  }

  render() {
    console.log(this.state);
    let table1, table2, instructions = null;
    if (this.state.in_game) {
      instructions = <small>Instructions: Place five ships size [5, 4, 3, 3, 2] on your board. When both players have done so, each player will choose a spot to attack on the opposing board. Play until one player has all their ships suck. Good luck.</small>;
      table1 = <Table state={this.state} channel={this.props.channel} updateState={this.updateState.bind(this)} player={1}/>;
      table2 = <Table state={this.state} channel={this.props.channel} updateState={this.updateState.bind(this)} player={2} />;
    }
    return (
      <div className="row">
        <div className="col col-8">
          <h3>Game: {this.props.code}</h3>
          {instructions}
          <div className="row mt-2">
            {table1}
            {table2}
          </div>
        </div>
        <div className="col col-4">
          <Chat state={this.state} channel={this.props.channel} updateState={this.updateState.bind(this)} />
        </div>
      </div>
    );
  }
};
