/**
 * Created by zhangpoor on 16/7/21.
 */
import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View
} from 'react-native';

import BaseView from './BaseView'


class MyView extends BaseView {



    render() {
        return super.render('abc');

    }
}




export default MyView;