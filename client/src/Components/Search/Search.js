import React, { Component } from 'react'
import axios from 'axios'

import './Search.css'

const baseURL = "https://meth-server.herokuapp.com"

class Search extends Component {
  constructor() {
    super();
    this.state = {
      movieData: {
        title: ''
      }
    };
    this.getMovie = this.getMovie.bind(this);

  }

  getMovie () {
    let searchTerm = document.getElementById("searchQuery").value;
    searchTerm = searchTerm.replace(/\s+/g, '_').toLowerCase();
    console.log(searchTerm);
    axios.get(`${baseURL}/movies/search/${searchTerm}`)
      .then(res => {
        console.log(res.data)
        this.setState({
          movieData: {
            title: res.data.title,
            overview: res.data.overview,
            budget: res.data.budget,
            revenue: res.data.revenue,
            runtime: res.data.runtime,
            tagline: res.data.tagline
          }
        });
      });
  }

  render () {
    const movieData = this.state.movieData;
    let movieInfo;
    if (movieData.title !== '') {
      movieInfo =         <div className="movieInfo">
                <h1>{ movieData.title.toUpperCase() }</h1>
                <h2>{ movieData.tagline }</h2>
                <p>{ movieData.overview }</p>
                <h3>Budget: ${ movieData.budget }</h3>
                <h3>Revenue: ${ movieData.revenue }</h3>
                <h3>Runtime: { movieData.runtime } minutes</h3>
              </div>
    } else {
      movieInfo = <div></div>
    }
    return (
      <section id="search" className="section search">
        <h2>Search for Multimedia:</h2>
        <input id="searchQuery" type="text" placeholder="Movie title to search" />
        <button type="submit" onClick={this.getMovie}>Submit Request</button>


        { movieInfo }
      </section>
    );
  }

}

export default Search;
