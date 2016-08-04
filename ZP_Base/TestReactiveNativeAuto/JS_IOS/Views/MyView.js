/**
 * Created by zhangpoor on 16/7/21.
 */
import React, { Component, PropTypes } from 'react';
import {
Animated,
    StyleSheet,
    View,
    Text,
    TouchableHighlight
} from 'react-native';

import UIFactory from './UIFactory'
import Item from './Game001/Item'



let _cannonWidth        = 40;
let _cannonHeight       = 60;
let _cannonBgColor      = 'orange';
let _cannonBasicSpeed   = 0.7;



let _enemyWidth         = 34;
let _enemyHeight        = _enemyWidth;
let _enemyBgColor       = 'red';
let _enemySpeed         = 1.1;
let _countOfEnemyPath   = 8;

let _pageHeight         = UIFactory.winHeight - UIFactory.navHeight - UIFactory.tabBarHeight;



function getGap(){

    let _a = UIFactory.winWidth - _enemyWidth * _countOfEnemyPath;
    let _c = _a / 10;

    return _c;
}

let _gap            = getGap();
let _roomSpace      = _gap + _enemyWidth;
let _fireTime       = 20;
let _enemyTimeCount = 800 / _fireTime ;

class MyView extends Component{

    constructor()
    {
        super();

        this.state      = {
            enemyViews:     PropTypes.array
        };

        this.timeCount          = 0;
        this.timer              = null;

        this.enemys             = [];
        this.state.enemyViews   = [];
        this.enemyCount         = this.enemys.length;
        this.lastPathNo         = 0;
        this.cannon             = this.createCannon();
        this.cannonSpeed        = 0;


        this.btnAdd             = UIFactory.createBtn(
            {backgroundColor:'yellow',width:70,height:30,left:210,top:5},
            'red',
            //this.addEnemy.bind(this)
            this.startTimer.bind(this)
        );
        this.btnMove            = UIFactory.createBtn(
            {backgroundColor:'blue',width:70,height:30,left:285,top:5},
            'red',
            this.stopTimer.bind(this)
        );

        this.btnLeft            = UIFactory.createBtn(
            {backgroundColor:'yellow',width:60,height:40,left:0,top:_pageHeight - 40},
            'red',

            this.speedBtnAciotn.bind(this)
        );
        this.btnRight           = UIFactory.createBtn(
            {backgroundColor:'blue',width:60,height:40,left:UIFactory.winWidth - 60,top:_pageHeight - 40},
            'red',
            this.speedBtnAciotn.bind(this)
        );

        //this.createEnemy();

    }

    info(){
        return ('现在敌人数量:'+this.enemyCount+'\n'+'当前屏幕宽度:'+UIFactory.winWidth);
    }


    render() {
        //alert('cannon:'+this.cannon+'\n'+
        //      'cannonView:'+this.cannon.getItemView());
        return (

            <View style={MyViewStyle.RootPageStyle}>
                {this.cannon.getItemView()}
                {this.state.enemyViews}
                <View style={MyViewStyle.InfoBarStyle}>
                    <Text style={MyViewStyle.InfoStyle}>
                        {this.info()}
                    </Text>
                    {this.btnAdd}
                    {this.btnMove}
                </View>
                {this.btnLeft}
                {this.btnRight}
            </View>

        );
    }


    /*
     *  Timer
     *
     */
    startTimer(){

        if(this.timer == null){

            this.timer = setInterval(
                () => this.timeFire(),
                _fireTime
            );
        }

    }

    stopTimer(){

        this.timer && clearInterval(this.timer);

        this.timer = null;
    }

    timeFire(){
        /// do bussiness
        this.enemyBussiness();



        this.moveEnemys();
        this.moveCannon();

        this.setState(this.state);
    }

/*
 *  EnemyBlock
 *
 */
    enemyBussiness(){


        this.timeCount++;
        if(this.timeCount >= _enemyTimeCount)
        {
            this.addEnemy();
            this.timeCount = 0;
        }

    }

    enemyXY(itemId){


        return({

            top:    40,
            left:   _gap + itemId * _roomSpace
        });

    }

    createEnemy(){

        let _pathNo     = Math.ceil(_countOfEnemyPath * Math.random()) - 1;

        var _pathFinal  = _pathNo;
        if(this.lastPathNo == _pathFinal){
            //如果是奇数,中间那个可能会重复
            _pathFinal = _countOfEnemyPath - 1 - _pathFinal;
        }

        this.lastPathNo = _pathFinal;

        var _e = new Item(
            MyViewStyle.EnemyBasicStyle,
            this.enemyXY(_pathFinal)
        );

        this.state.enemyViews.push(_e.view);
        this.enemys.push(_e);
        this.enemyCount = this.enemys.length;


    }

    addEnemy(){

        this.createEnemy();
        //this.setState(this.state);
    }

    moveEnemys() {

        this.state.enemyViews = [];
        var _es = this.enemys;
        this.enemys = [];
        for(var i = 0 ; i < this.enemyCount ;i++){
            var _e = _es[i];
            var _v = _e.moveY(_enemySpeed);

            if(_e.state.mTop < _pageHeight){
                this.enemys.push(_e);
                this.state.enemyViews.push(_v);

            }
        }

        this.enemyCount         = this.enemys.length;

        //this.setState(this.state);
    }

/*
 *  Cannon
 *
 */
    createCannon(){
        var _c = new Item(
            MyViewStyle.CannonBasicStyle,
            {
                left:(UIFactory.winWidth - _cannonWidth)/2.0,
                top:_pageHeight - _cannonHeight - 10,

            }
        );

        return _c;

    }

    moveCannon() {
        let _rxBoundle =  UIFactory.winWidth - this.cannon.mWidth;
        let _lxBoundle =  0;


        this.cannon.moveX(this.cannonSpeed);
        if(this.cannon.state.mLeft > _rxBoundle)
        {
            this.cannon.state.mLeft = _rxBoundle;
            this.cannonSpeed = 0;
        }
        if(this.cannon.state.mLeft < 0)
        {
            this.cannon.state.mLeft = 0;
            this.cannonSpeed = 0;
        }
        //this.setState(this.state);
    }

/*
 *  SpeedButtonAction
 */
    speedBtnAciotn(e){

        qqqq
        alert(Object.keys(e));
    }

}




const MyViewStyle = StyleSheet.create({
    RootPageStyle:
    {
        position:'absolute',
        width: UIFactory.winWidth,
        height:_pageHeight,
        top: UIFactory.navHeight,
        backgroundColor: 'gray'
    },
    InfoStyle:{
        position:'absolute',
        width: 200,
        height:35,
        top: 0,
        left:0,
        backgroundColor: 'black',
        color:'white',
        fontSize:10
    },
    InfoBarStyle:{
        position:'absolute',
        width: UIFactory.winWidth,
        height:35,
        top: 0,
        left:0,
        backgroundColor: '#218141'
    },
    EnemyBasicStyle:{
        position:'absolute',
        width: _enemyWidth,
        height:_enemyHeight,
        backgroundColor: _enemyBgColor,
        borderRadius:_enemyWidth/2.0

    },
    CannonBasicStyle:{
        position:'absolute',
        width: _cannonWidth,
        height:_cannonHeight,
        backgroundColor: _cannonBgColor

    },


});


export default MyView;


/*

 this.state      = {
 fadeAnim:(new Animated.Value(0)), //设置初始值
 viewAStyle:MyViewStyle.A,
 viewStyle:MyViewStyle.Bg_A
 };

 this.flag       = true;

 this.aaa        = new UIFactory().aFun();
 this.anim=this.anim.bind(this);
 //this.BtnAClick=this.BtnAClick.bind(this);


 this.viewA      = UIFactory.createView(this.state.viewAStyle);
 this.btnA       = UIFactory.createBtn(
 {backgroundColor:'yellow',width:120,height:50,left:100,top:100},
 'red',()=>this.BtnAClick()
 );
 this.aniView    = UIFactory.createAnimatedView(
 {backgroundColor:'pink',width:50,height:50,left:50,top:120},
 this.state.fadeAnim
 );
 anim(p0)
 {

 //console.log('p0:'+p0);
 //alert('p0:'+_abc.ppp);

 Animated.timing(
 this.state.fadeAnim,//初始值
 {
 toValue: p0,    //结束值
 duration:2000   //持续时间
 }
 ).start(

 ()=>this.anim(100 - p0) // fun
 //this.anim(100 - p0)   // void

 );
 }
 {this.eView}
 <View style={[
 MyViewStyle.EnemyBasicStyle,
 {top:this.state.eTop}
 ]} />
 {this.enemyViews}
 <View style={[
 MyViewStyle.EnemyBasicStyle,
 {top:this.state.eTop}]}/>
 {this.state.enemyViews}

 shouldComponentUpdate(nextProps, nextState)
 {
 alert('old'+ this.state.viewASheet);
 alert('next'+ nextState.viewASheet);

 return this.state.viewASheet !== nextState.viewASheet;
 }

 Red: {
 backgroundColor:'red',
 width:  200,
 height: 100
 },
 Brown: {
 backgroundColor:'brown',
 width:  200,
 height: 100
 },
 A: {
 left:10,
 top:10,
 width:  200,
 height: 100,
 backgroundColor:'green'
 },

 Bg_A:{
 left:0,
 marginTop:64,
 width:  320,
 height: 600,
 opacity: 0.5,
 backgroundColor:'#112233'
 },
 Bg_B:{
 width:  320,
 height: 600,
 backgroundColor:'#332211'
 },

 */

