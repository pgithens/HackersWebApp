import React, { Component } from 'react'

import './Search.css'

class Search extends Component {
  render () {
    return (
      <section id="search" class="section search">
        <h2>Search for Multimedia:</h2>
        <input type="text" placeholder="Movie title, tv show title, etc." />
        <button type="submit">Submit Request</button>
      </section>
    );
  }

}

export default Search;
