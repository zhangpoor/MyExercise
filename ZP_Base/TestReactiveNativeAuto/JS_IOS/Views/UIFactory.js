/**
 * Created by zhangpoor on 16/7/21.
 */

import React, { Component } from 'react';
import {
    Text,
    View,
    StyleSheet,
    Animated,
    TouchableHighlight,
    Dimensions
} from 'react-native';

import Enemy from './Game001/Item'


class BaseObject {
    constructor(){


    }

    aFun(){

        return 'aaa';
    }
}



let UIFactory = BaseObject;
UIFactory.aaa = ()=>{

    return 'abcd';
}


UIFactory.createView = (cStyle)=>{

    return (
        <View style={[{
            position:'absolute'
        },cStyle]}/>
    );

}




UIFactory.createBtn = (cStyle,downColor,clickFun)=>{

    return (

        <View style={[
            {
                position:'absolute',
            },
            {
                left:   cStyle.left,
                top:    cStyle.top,
                width:  cStyle.width,
                height: cStyle.height
            }
        ]}>
            <TouchableHighlight onPress={clickFun}
                                underlayColor={downColor}>
                <View style={[
                    {
                        position:'absolute',
                    },
                    {
                        width:  cStyle.width,
                        height: cStyle.height,
                         backgroundColor: cStyle.backgroundColor
                     }
                ]}/>
            </TouchableHighlight>
        </View>


    );

}


UIFactory.createAnimatedView = (cStyle,tx)=>{

    return (
        <Animated.View style={[
            {position:'absolute'},
            cStyle,
            {
                transform:[
                    {translateX:tx}
                ]
            }
        ]}/>
    );

}

UIFactory.winWidth      = Dimensions.get('window').width;
UIFactory.winHeight     = Dimensions.get('window').height;
UIFactory.navHeight     = 64;
UIFactory.tabBarHeight  = 44;

//UIFactory.styleWinWithNavAndTab

export default UIFactory;
/*

 <TouchableHighlight onPress={()=>{Alert.alert('hello')}}
 underlayColor='yellow'
 sytle={{width: w,height: h,marginLeft:x,marginTop:y}}>
 </TouchableHighlight>
 */





/*
function abc(){

    return 'abc';
}


class UIFactory extends Component {


    constructor(a, b)
    {
        super();
        this.a = 0;
        this.b = 20;
        this.timerNum = -1;
    }


    CreatView(){

        return (<View style={styles.container}>

            <Text>abcd</Text>

        </View>);
    }


    Refresh() {
        if(this.a < this.b){

            this.a++;
            this.setState({});
        }
        else
        {
            this.a = "timer ok";
            this.setState({});
            clearInterval(this.timerNum);

        }

    }


    OnPress(){
        this.a = 0;
        *
        var MyInterval=setInterval(()=>{
            this.a++;
            this.setState({});
        },1000);
        *

        this.timerNum = setInterval(this.Refresh.bind(this),1000);
    }

    render(p0) {

        return (

            <View style={styles.container}>
                <TouchableHighlight onPress={this.OnPress.bind(this)}>
                        <Text style={styles.welcome}>
                            {this.a}
                        </Text>
                </TouchableHighlight>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
        width:300,
        color:'#ffffff',
        backgroundColor: '#0000ff'
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});



export default UIFactory;

   */