import React from 'react';
import { Provider } from 'react-redux';
import { store } from './Common';
import Root from './root';
import Home from './Home';
import Wealth from './Wealth';

const App = (props) => (
    <Provider store={store}>
        <Root {...props} />
    </Provider>
);

export {
    App,
    Home,
    Wealth,
};

/**
    provider store
    connect (store & dispatch) => (state & actions) => component.props
    <Provider store={store}>
        <Connect>
            <Home />
        </Connect>
    </Provider>

    单向数据流 state & props: Parent->Child->Text
    <Parent>
        <Child>
            <Text/>
        </Child>
    </Parent>

    onPress -> actions[key] -> dispatch(actionCreator())
        -> store.dispatch(action) -> reducer(store.getState(), action)
        -> changedState -> store -> render
 */
