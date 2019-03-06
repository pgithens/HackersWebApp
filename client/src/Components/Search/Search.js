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
      },
      status: "loading",
      errorMessage: ""
    };
    this.getMovie = this.getMovie.bind(this);

  }

  getMovie () {
    let inputValue = document.getElementById("searchQuery").value;
    let searchTerm = inputValue.replace(/\s+/g, '_').toLowerCase();
    axios.get(`${baseURL}/movies/search/${searchTerm}`)
      .then(res => {
        console.log(res.data);
        this.setState({
          status: "success",
          movieData: {
            title: res.data.title,
            overview: res.data.overview,
            budget: res.data.budget,
            revenue: res.data.revenue,
            runtime: res.data.runtime,
            tagline: res.data.tagline
          }
        });
      })
      .catch(error => {
          console.log(error);
          this.setState({
            status: "failure",
            errorMessage: `${inputValue} not found in database!`
          });
      });
  }

  render () {
    const movieData = this.state.movieData;
    let movieInfo;
    if (this.state.status === "success") {
      movieInfo =         <div className="movieInfo">
                <h1>{ movieData.title.toUpperCase() }</h1>
                <h2>{ movieData.tagline }</h2>
                <p>{ movieData.overview }</p>
                <h3>Budget: ${ movieData.budget }</h3>
                <h3>Revenue: ${ movieData.revenue }</h3>
                <h3>Runtime: { movieData.runtime } minutes</h3>
              </div>
    } else if (this.state.status === "loading") {
      movieInfo = <div></div>
    } else if (this.state.status === "failure"){
      movieInfo = <div><h1>{ this.state.errorMessage }</h1></div>
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
