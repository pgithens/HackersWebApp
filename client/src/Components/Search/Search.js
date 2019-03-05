import React, { Component } from 'react'
import axios from 'axios'

import './Search.css'

const baseURL = "http://cors.io/?localhost:8080"

class Search extends Component {
  movieData = {}

  getMovie () {
    axios.get(`${baseURL}/movies/api/${document.getElementById("searchQuery").value}`)
      .then(res => {
        console.log("request made: ");
        console.log(res);
      })
      .catch(function(error) {
        console.log(error);
      });
  }

  render () {
    return (
      <section id="search" className="section search">
        <h2>Search for Multimedia:</h2>
        <input id="searchQuery" type="text" placeholder="Movie title, tv show title, etc." />
        <button type="submit" onClick={this.getMovie}>Submit Request</button>
      </section>
    );
  }

}

export default Search;
