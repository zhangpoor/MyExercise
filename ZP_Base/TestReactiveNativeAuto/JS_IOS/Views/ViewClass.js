/**
 * Created by zhangpoor on 16/7/25.
 */
import React, { Component, PropTypes } from 'react';
import {
    View,
    StyleSheet,
} from 'react-native';

export default class ViewClass extends Component
{
    static propTypes = {
        vcSheet: PropTypes.style
        //bgColor: PropTypes.string
    }

/*
    constructor(props) {
        super();
        this.state      = {

            mySheet:props.vcSheet

        }
    }
*/
    render() {

        return (

            <View style={
                this.props.vcSheet
            } />

        );
    }

}


