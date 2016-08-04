
export const FETCH_USER_START = 'FETCH_USER_START';
export const FETCH_USER_SUCCESS = 'REQUEST_USER_SUCCESS';
export const FETCH_USER_FAIL = 'FETCH_USER_FAIL';

function startFetch() {
    return {
        type: FETCH_USER_START,
    };
}

function receiveUser(users) {
    return {
        type: FETCH_USER_SUCCESS,
        users,
    };
}

function fetchFailed(error) {
    return {
        type: FETCH_USER_FAIL,
        error,
    };
}

export function fetchUser() {
    return dispatch => {
        dispatch(startFetch());
        fetch('https://api.github.com/users/gaearon/followers', {
            headers: {
                'Cache-Control': 'no-cache',
            },
        })
        .then(response => response.json())
        .then(json => {
            dispatch(receiveUser(json));
        })
        .catch(error => {
            console.log(`error = ${error}`);
            dispatch(fetchFailed(error));
        });
    };
}
