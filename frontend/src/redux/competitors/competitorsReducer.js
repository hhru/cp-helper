import {createReducer} from 'redux-create-reducer';
import {FETCH_COMPETITORS} from './competitorsActions';

export const initialState = {
    competitors: undefined,
};

export const competitorsReducer = createReducer(initialState, {

    [FETCH_COMPETITORS](state, action) {
        return {
            ...state,
            competitors: action.competitors,
        };
    },
});
