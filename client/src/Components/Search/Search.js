import React, { Component } from 'react'
import axios from 'axios'

import './Search.css'

const baseURL = "http://meth-server.herokuapp.com"

class Search extends Component {
  constructor() {
    super();
    this.state = {
      movieData: {
        comment: '',
        name: ''
      }
    };
    this.getMovie = this.getMovie.bind(this);

  }

  getMovie () {
    axios.get(`${baseURL}/${document.getElementById("searchQuery").value}`)
      .then(res => {
        console.log(res.data)
        this.setState({
          movieData: {
            comment: res.data.com,
            name: res.data.user
          }
        });
      });
  }

  render () {
    const movieData = this.state.movieData;
    return (
      <section id="search" className="section search">
        <h2>Search for Multimedia:</h2>
        <input id="searchQuery" type="text" placeholder="Movie title, tv show title, etc." />
        <button type="submit" onClick={this.getMovie}>Submit Request</button>

        <h1>{ movieData.name }</h1>
        <h1>{ movieData.comment }</h1>
      </section>
    );
  }

}

export default Search;
