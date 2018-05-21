import css from "../css/app.scss"

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

import React from 'react';
import ReactDOM from 'react-dom';

import WelcomeTitle from './components/WelcomeTitle';

ReactDOM.render(<WelcomeTitle />, document.getElementById("welcome-title-container"));

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
