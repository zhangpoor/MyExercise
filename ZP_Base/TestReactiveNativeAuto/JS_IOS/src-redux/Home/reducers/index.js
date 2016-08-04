// reducer
import { FETCH_USER_START, FETCH_USER_SUCCESS, FETCH_USER_FAIL } from '../actions';

const origin = {
    fetching: false,
    success: false,
    items: [],
};

export function users(state = origin, action) {
    switch (action.type) {
        case FETCH_USER_START:
            return {
                ...state,
                fetching: true,
                success: false,
                items: [],
            };
        case FETCH_USER_SUCCESS:
            return {
                ...state,
                fetching: false,
                success: true,
                items: action.users,
            };
        case FETCH_USER_FAIL:
            return {
                ...state,
                fetching: false,
                success: false,
                error: action.error,
            };
        default:
            return state;
    }
}
