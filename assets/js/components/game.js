import React from 'react';
import Chat from './chat';

export default class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = this.props.state;
    this.props.channel.on("state_update", this.setState.bind(this));
  };

  updateUser(e) {
    if(e) e.preventDefault();
    let chat = this.props.state.chat;
    let user = this.refs.username.value;
    console.log(user);
    this.props.channel.push("new_player", {chat: chat, user_name: user});
  }

  renderPlayerName() {
    console.log(window.user_name);
  }

  render() {
    console.log(this.props.state);
    console.log(window.user_name);
    return (
      <div>
          <h3>Game: {this.props.code}</h3>
          <Chat state={this.props.state} channel={this.props.channel} updateUser={this.updateUser} />
      </div>
    );
  }
};
