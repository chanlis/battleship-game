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
    })
    .receive("error", resp => {
      console.log("Unable to join", resp);
    })
  start
}

function start() {
  let main = document.getElementById('main');
  let html = <button id="start-game" className="btn btn-primary" onClick={renderGame} value="ABCD">Join Game</button>
  ReactDOM.render(html, main);
}

$(start);
