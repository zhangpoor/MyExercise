import React, { Component, PropTypes } from 'react';
import { View, TextInput, Text } from 'react-native';
import styles from '../../Styles';
import { changeAmount } from '../actions';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

const actions = { changeAmount };

class Wealth extends Component {

    static propTypes = {
        amount: PropTypes.string,
        actions: PropTypes.object,
    };

    render() {
        const amount = this.props.amount;
        const onChangeAmount = text => this.props.actions.changeAmount(text);
        return (
            <View style={styles.container}>
                <TextInput style={styles.textInput} onChangeText={onChangeAmount} value={amount} />
                <Text style={[styles.text, { marginTop: 10 }]}>{`amount: ${amount}`}</Text>
            </View>
        );
    }
}

export default connect(state => ({
    amount: state.wealth.amount,
}), dispatch => ({
    actions: bindActionCreators(actions, dispatch),
}))(Wealth);

/**
    connect(mapStateToProps, mapDispatchToProps, mergeProps) -> function(Component)
        -> Connect(inherits Component)
    Connect {
        render() {
            return WrappedComponent with mergedProps;
        }
    }

    var mappedState = mapState(store.getState(), props);
    var mappedDispatch = mapDispatch(store.dispatch, props);

    bindActionCreators(actionCreators, dispatch) {
        (key, actionCreator) -> (key, function() { return dispatch(actionCreator(arguments)) })
    }
*/
