// reducers
import { CHANGE_AMOUNT } from '../actions';

const origin = {
    amount: '0',
};

export function wealth(state = origin, action) {
    if (action.type === CHANGE_AMOUNT) {
        return {
            ...state,
            amount: action.amount,
        };
    }
    return state;
}
