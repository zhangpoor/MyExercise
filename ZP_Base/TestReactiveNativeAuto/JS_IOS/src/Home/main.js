import React, { Component, PropTypes } from 'react';
import { View, TouchableHighlight, Text } from 'react-native';
import Wealth from '../Wealth';
import styles from '../Styles';

class Home extends Component {

    static propTypes = {
        navigator: PropTypes.object,
        index: PropTypes.number,
    };

    constructor(props) {
        super(props);
        this.onPressTest = this.onPressTest.bind(this);
        this.onPressWealth = this.onPressWealth.bind(this);
        this.changeAmount = this.changeAmount.bind(this);
        this.state = {
            text: 'Please click Test',
            amount: '0',
        };
    }

    onPressTest() {
        this.setState({
            text: `time = ${new Date().getTime()}`,
        });
    }

    onPressWealth() {
        this.props.navigator.push({
            title: 'Asset from Click',
            component: Wealth,
            callback: this.changeAmount,
            amount: this.state.amount,
         });
    }

    changeAmount(amount) {
        this.setState({
            amount,
        });
    }

    render() {
        const text = this.state.text;
        const amount = this.state.amount;
        const button = this.props.index === 0 ? (<TouchableHighlight onPress={this.onPressWealth}>
            <Text style={styles.text}>Goto Amount</Text></TouchableHighlight>) : (<View />);
        return (
            <View style={styles.container}>
                <Text style={styles.text}>{text}</Text>
                <TouchableHighlight onPress={this.onPressTest}>
                    <Text style={styles.text}>Test</Text>
                </TouchableHighlight>
                <Text style={[styles.text, { marginTop: 15 }]}>{`amount: ${amount}`}</Text>
                {button}
            </View>
        );
    }
}

export default Home;
