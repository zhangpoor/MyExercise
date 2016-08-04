import React, { Component, PropTypes } from 'react';
import { View, TouchableHighlight, Text } from 'react-native';
import Wealth from '../../Wealth';
import styles from '../../Styles';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { fetchUser } from '../actions';

const actions = { fetchUser };

class Home extends Component {

    static propTypes = {
        navigator: PropTypes.object,
        index: PropTypes.number,
        amount: PropTypes.string,
        actions: PropTypes.object,

        users: PropTypes.array,
        isFetching: PropTypes.bool,
        success: PropTypes.bool,
        error: PropTypes.object,
    };

    constructor(props) {
        super(props);
        this.onPressTest = this.onPressTest.bind(this);
        this.onPressWealth = this.onPressWealth.bind(this);
    }

    onPressTest() {
        this.props.actions.fetchUser();
    }

    onPressWealth() {
        this.props.navigator.push({
            title: 'Wealth from Click',
            component: Wealth,
         });
    }

    makeUserText(isFetching, success, users, error) {
        let text = 'Please click Test';
        if (isFetching) {
            text = 'Fetching Gaearon\'s followers';
        } else if (success) {
            text = `Gaearon has ${users.length} followers`;
        } else if (error) {
            text = `Fetch followers failed: ${error}`;
        }
        return text;
    }

    render() {
        const { amount, isFetching, success, users, error } = this.props;
        const text = this.makeUserText(isFetching, success, users, error);
        return (
            <View style={styles.container}>
                <Text style={styles.text}>{text}</Text>
                <TouchableHighlight onPress={this.onPressTest}>
                    <Text style={styles.text}>Test</Text>
                </TouchableHighlight>
                <Text style={[styles.text, { marginTop: 15 }]}>{`amount: ${amount}`}</Text>
                <View>
                    {this.props.index === 0 && (
                        <TouchableHighlight onPress={this.onPressWealth}>
                            <Text style={styles.text}>Goto Wealth</Text>
                        </TouchableHighlight>
                    )}
                </View>
            </View>
        );
    }
}

export default connect(state => ({
    amount: state.wealth.amount,
    isFetching: state.users.fetching,
    success: state.users.success,
    users: state.users.items,
    error: state.users.error,
}), dispatch => ({
    actions: bindActionCreators(actions, dispatch),
}))(Home);
