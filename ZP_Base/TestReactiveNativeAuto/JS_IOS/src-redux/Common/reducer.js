import { combineReducers } from 'redux';
import { wealth } from '../Wealth/reducers';
import { users } from '../Home/reducers';

const reducer = combineReducers({
    wealth,
    users,
});

export default reducer;

/**
    combineReducers({ reducer1, reducer2 }) -> function reducer(state, action) {
        keys => {   // keys = ['reducer1', 'reducer2']
            currentReducer = reducers[key];
            nextState[key] = currentReducer(state[key], action);
        }
        return nextState;
    }
*/
