/**
 * Created by zhangpoor on 16/7/21.
 */

import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    TouchableHighlight
} from 'react-native';



class BaseView extends Component {


    constructor(a, b)
    {
        super();
        this.a = 0;
        this.b = 20;
        this.timerNum = -1;
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
        /*
        var MyInterval=setInterval(()=>{
            this.a++;
            this.setState({});
        },1000);
        */

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



export default BaseView;