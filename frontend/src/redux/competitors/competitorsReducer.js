import {createReducer} from 'redux-create-reducer';
import {UPDATE_COMPETITORS} from './competitorsActions';

export const initialState = {
    competitors: undefined,
};

export const competitorsReducer = createReducer(initialState, {

    [UPDATE_COMPETITORS](state, action) {
        return {
            ...state,
            competitors: action.competitors,
        };
    },
});
