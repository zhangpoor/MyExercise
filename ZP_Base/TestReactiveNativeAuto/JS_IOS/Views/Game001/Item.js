/**
 * Created by zhangpoor on 16/8/2.
 */
import React, { Component , PropTypes } from 'react';
import {
    Animated,
    StyleSheet,
    View
} from 'react-native';



class Item
{
    constructor(bStyle,eStyle){

        this.state      = {
            basicStyle:     PropTypes.style,
            mTop:           PropTypes.number,
            mLeft:          PropTypes.number
        };

        this.state.basicStyle = bStyle;
        this.state.mTop       = eStyle.top;
        this.state.mLeft      = eStyle.left;
        this.mWidth           = bStyle.width;
        this.mHeight          = bStyle.height;
    }

    getItemView(){

        return (

            <View style={[
                    this.state.basicStyle,
                    {
                        left:   this.state.mLeft,
                        top:    this.state.mTop
                    }
             ]}/>
        );
    }



    moveY(yValue)
    {
        this.state.mTop += yValue;

        return (this.getItemView());
    }

    moveX(xValue)
    {
        this.state.mLeft += xValue;

        return (this.getItemView());
    }
}




export default Item;

