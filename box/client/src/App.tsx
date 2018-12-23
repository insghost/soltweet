import React, { Component } from 'react';
import './App.css';
import Container from './components/container'
import styled from '@emotion/styled'
import { jsx, css } from '@emotion/core'
import Tweet from './components/tweet';
import WriteTweet from './components/write-tweet';
import { Tweet as TweetType } from './types/types'
import SolTweet from "./contracts/SolTweet.json";
import getWeb3 from "./utils/getWeb3";
jsx;
/** @jsx jsx */

const H1 = styled.h1`
  text-align: center;
`

interface HandleSubmitTweetArgs {
  author: string
  tweetText: string
}

interface IState {
  tweets: TweetType[],
  web3: any
  accounts: any
  contract: any
  username?: string
}

class App extends Component {
  state : IState = {
    tweets: [
      // {
      //   author: 'fake-author-1',
      //   tweetText: 'fake-text-1'
      // },
      // {
      //   author: 'fake-author-2',
      //   tweetText: 'fake-text-2'
      // }
    ],
    web3: null,
    accounts: null,
    contract: null,
    username: 'GhostRider'
  }

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = (SolTweet as any).networks[networkId];
      // console.log(SolTweet.networks)
      const instance = new web3.eth.Contract(
        SolTweet.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance })
      this.setup()
      // this.getTweets()
      // const res = await instance.methods._createUser('GhostRider').call();
      // const user = await instance.methods.users(0).call();
      // console.log(user);
      // console.log(res);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  setup = async () => {
    const { accounts, contract } = this.state

    // const numberOfTweets = await contract.methods._getNumberOfTweets().call()
    const numberOfTweets = 2
    const tweets: any = []
    for(let i = 0; i < numberOfTweets; i++) {
      const tweet = await contract.methods.tweets(i).call()
      const { text } = tweet
      tweets.push({
        author: 'GhostRider',
        tweetText: text
      })
    }
    this.setState({ tweets })
    console.log(tweets);
    // console.log(res)
    // const user = await contract.methods.users(1).call()
    // console.log(user)
  }

  // getTweets = async () => {
  //   const { accounts, contract } = this.state;

  //   // Stores a given value, 5 by default.
  //   // await contract.methods.set(5).send({ from: accounts[0] });

  //   // Get the value from the contract to prove it worked.
  //   // const response = await contract.methods.users(0).call();
  //   // console.log(response);

  //   // Update state with the result.
  //   // this.setState({ tweets: response });
  // };

  handleSubmitTweet = async ({
    author,
    tweetText
  } : HandleSubmitTweetArgs) => {
    const { accounts, contract } = this.state

    const tweet = {
      author,
      tweetText
    }
    this.setState({
      tweets: [tweet, ...this.state.tweets]
    })
    const res = await contract.methods._createTweet(0, tweetText).send({ from: accounts[0] })
    console.log(res)
    const tweetRes = await contract.methods.tweets(0).call()
    console.log(tweetRes)
  }

  render() {
    const { username } = this.state
    return (
      <Container>
        <div>
          <H1>SolTweet</H1>
          <h2
            css={css`
              color: red;
            `}
          >
            Logged in as {username}
          </h2>
        </div>
        <div>
          {this.state.tweets.map((tweet, idx) => <Tweet {...tweet} key={idx} />)}
        </div>
        <WriteTweet
          handleSubmitTweet={this.handleSubmitTweet}
        />
      </Container>
    );
  }
}

export default App
