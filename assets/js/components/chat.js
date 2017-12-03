import React from 'react';
import ReactDOM from 'react-dom';

class Message extends React.Component {
  render() {
    return (
      <tr>
        <td>
          <strong>{this.props.user}: </strong>
          {this.props.text}
        </td>
      </tr>
    );
  }
};

class User extends React.Component {
  render() {
    return (
        <form className="input-group" onSubmit={this.props.updateUser.bind(this)}>
          <input type="text" className="form-control" ref="username" placeholder="enter user name"></input>
          <button className="btn btn-primary" type="submit">Submit</button>
        </form>
    );
  }
};

export default class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.props.state;
  }

  render() {
    let messages = this.props.messages
    let count = 1;
    let renderMessages = _.map(messages, m => (
      <Message user={m.user} text={a.text} key={count++} />
    ));

    return (
      <div id="chat">
        {renderMessages}
        <div className="input-group">
          <input type="text" className="form-control" placeholder="type message here"></input>
          <span className="input-group-btn">
            <button className="btn btn-secondary" type="button">Send</button>
          </span>
        </div> 
        <User state={this.props.state} channel={this.props.channel} updateUser={this.props.updateUser} />
      </div>
    );
  }
};
