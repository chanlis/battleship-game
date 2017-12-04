import "phoenix_html";
import socket from './socket';
import React from 'react';
import ReactDOM from 'react-dom';
import Game from './components/game';

function renderGame(e) {
  let div = document.getElementById('game');
  let code = e.target.value;
  console.log(code)
  let channel = socket.channel("game:" +  code, {});
  channel.join()
    .receive("ok", state0 => {
      console.log("Join successfully", state0);
      ReactDOM.render(<Game code={code} state={state0} channel={channel} />, div);
      let chat = state0.chat;
      let user = window.user_name;
      channel.push("new_player", {user_name: user});
    })
    .receive("error", resp => {
      console.log("Unable to join", resp);
    })
}

function start() {
  let main = document.getElementById('main');
  let html = <div id="start-game" className="col col-4 mt-5"><button className="btn btn-outline-primary btn-block" onClick={renderGame} value="ABCD">Join Game</button></div>
  ReactDOM.render(html, main);
}

$(start);