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
    return (
      <div className="row">
        <div className="col col-8">
          <h3>Game: {this.props.code}</h3>
          <Table />
        </div>
        <div className="col col-4">
          <Chat state={this.state} channel={this.props.channel} updateState={this.updateState.bind(this)} />
        </div>
      </div>
    );
  }
};
