// Action creators
export const CHANGE_AMOUNT = 'CHANGE_AMOUNT';

export function changeAmount(amount) {
    return {
        type: CHANGE_AMOUNT,
        amount,
    };
}
