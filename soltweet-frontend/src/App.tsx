import React, { Component } from 'react';
import './App.css';
import Container from './components/container'
import styled from '@emotion/styled'
import { jsx } from '@emotion/core'

const H1 = styled.h1`
  text-align: center;
`

class App extends Component {
  render() {
    return (
      <Container>
        <div>
          <H1>SolTweet</H1>
        </div>
      </Container>
    );
  }
}

export default App
