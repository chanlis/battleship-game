import React from 'react';
import ReactDOM from 'react-dom';

class Message extends React.Component {
  render() {
    console.log(this.props.text);
    return (
      <tr>
        <td>
          <strong>{this.props.user.name}: </strong>
          {this.props.text}
        </td>
      </tr>
    );
  }
};

export default class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.props.state;
    this.sendMessage = this.sendMessage.bind(this);
    this.props.channel.on("state_update", s => this.props.updateState(s));
  }

  sendMessage(e) {
    if(e) e.preventDefault();
    let message = this.refs.message.value;
    this.props.channel.push("new_message", {message: message});
  }

  render() {
    let count = 1;
    let messages = this.props.state.chat.messages;
    let renderMessages = _.map(messages, m => (
      <Message user={m.user} text={m.text} key={count++} />
    ));

    return (
      <div id="chat">
        <form className="input-group" onSubmit={this.sendMessage.bind(this)}>
          <input type="text" className="form-control" placeholder="type message here" ref="message"></input>
          <button className="btn btn-sm btn-secondary" type="submit">Send</button>
        </form> 
        <table className="table">
          <tbody>
            {renderMessages}
          </tbody>
        </table>
      </div>
    );
  }
};
