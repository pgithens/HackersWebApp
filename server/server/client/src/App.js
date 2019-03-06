import React, { Component } from 'react';

import Search from "./Components/Search/Search"
import logo from './logo.svg';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          Multimedia Entertainment Tier Heuristic
        </header>
        <Search />
      </div>
    );
  }
}

export default App;
