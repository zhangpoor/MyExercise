/**
* Sample React Native App
* https://github.com/facebook/react-native
* @flow
*/

import React, { Component } from 'react';
import { AppRegistry } from 'react-native';
import { App, Home, Wealth } from './src';
//import { App, Home, Wealth } from './src-redux';

import MyView from './Views/MyView'

const routes = [
    { title: 'Home', component: Home, index: 0 },
    { title: 'Wealth', component: Wealth, index: 1 },
    { title: 'Home Again', component: Home, index: 2 },
];

class TestRedux extends Component {

    render() {
        return (
            <App routes={routes} />
        );
    }
}





AppRegistry.registerComponent('mView', () => MyView);
AppRegistry.registerComponent('TestRedux', () => TestRedux);
