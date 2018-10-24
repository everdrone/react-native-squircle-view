import React, { Component } from 'react';
import { StyleSheet, Text, View, StatusBar } from 'react-native';

import SquircleView from 'react-native-squircle-view';

export default class App extends Component {
  render() {
    return (
      <View style={styles.container}>
        <StatusBar backgroundColor="blue" barStyle="light-content" />
        <SquircleView style={styles.squircle1}>
          <SquircleView style={styles.squircle2}>
            <SquircleView style={styles.squircle3}>
              <Text style={styles.welcome}>Hello There</Text>
            </SquircleView>
          </SquircleView>
        </SquircleView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#212225',
  },
  squircle1: {
    width: 300,
    height: 300,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#333437',
    borderRadius: 100,
    shadowColor: '#050031',
    shadowOpacity: 0.15,
    shadowOffset: {
      width: 0,
      height: 10,
    },
    shadowRadius: 8,
  },
  squircle2: {
    width: 225,
    height: 225,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#74B4D6',
    borderRadius: 75,
    shadowColor: '#050031',
    shadowOpacity: 0.15,
    shadowOffset: {
      width: 0,
      height: 10,
    },
    shadowRadius: 8,
  },
  squircle3: {
    width: 150,
    height: 150,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#DDDEDE',
    borderRadius: 50,
    shadowColor: '#050031',
    shadowOpacity: 0.15,
    shadowOffset: {
      width: 0,
      height: 10,
    },
    shadowRadius: 8,
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    color: '#333437',
  },
});
