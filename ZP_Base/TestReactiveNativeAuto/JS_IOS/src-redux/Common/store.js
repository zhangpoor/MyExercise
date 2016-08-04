import { applyMiddleware, createStore } from 'redux';
import thunk from 'redux-thunk';
import reducer from './reducer';

const middlewares = [thunk];
const store = applyMiddleware(...middlewares)(createStore)(reducer);
export default store;

/**
store:
createStore(reducer, initialState, enhancer) -> store { getState(), dispatch(action), subscribe(listener) }
1 store = 1 reducer + 1 currentState + multi listeners;
dispatch: function(action) {
    currentState = reducer(currentState, action);
    listeners.each { listener(); }
}

middleware({getState, dispatch}) -> function(dispatch) -> new dispatch func

applyMiddleware(...middleware) -> function(createStore)
    -> function(reducer, initialState, enhancer) -> store

applyMiddleware:
    createStore();
    chain = middlewares.map(middleware => middleware({getState, dispatch}));
    store.dispatch = chain(store.dispatch);
    return store;

thunk:
    store.dispatch = function(action) {
        if (action === 'function') {    // action creators
            action(dispatch, getState, extraArgument)
        } else {
            dispatch(action);
        }
    }

logger:
    store.dispatch = function(action) {
        log before;
        returnVal = dispatch(action);
        log after & catch;
        return returnVal;
    }
*/
