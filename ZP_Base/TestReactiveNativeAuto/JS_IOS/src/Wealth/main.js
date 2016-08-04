import React, { Component, PropTypes } from 'react';
import { View, TextInput, Text } from 'react-native';
import styles from '../Styles';

class Wealth extends Component {

    static propTypes = {
        callback: PropTypes.func,
        amount: PropTypes.string,
    };

    constructor(props) {
        super(props);
        this.onChangeAmount = this.onChangeAmount.bind(this);

        this.state = {
            amount: props.amount || '0',
        };
    }

    onChangeAmount(amount) {
        this.setState({
            amount,
        });

        if (this.props.callback) {
            this.props.callback(amount);
        }
    }

    render() {
        const amount = this.state.amount;
        return (
            <View style={styles.container}>
                <TextInput style={styles.textInput} onChangeText={this.onChangeAmount} value={amount} />
                <Text style={[styles.text, { marginTop: 10 }]}>{`asset: ${amount}`}</Text>
            </View>
        );
    }
}

export default Wealth;
