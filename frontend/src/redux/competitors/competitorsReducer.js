import {createReducer} from 'redux-create-reducer';
import {FETCH_COMPETITORS, ADD_COMPETITOR, DELETE_COMPETITOR, RESET_COMPETITORS} from './competitorsActions';

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

    [ADD_COMPETITOR](state, action) {
        let competitor = action.competitor;
        return {
            ...state,
            competitors: {...state.competitors, [competitor.id]: competitor},
        };
    },

    [DELETE_COMPETITOR](state, action) {
        let competitorsNew = {...state.competitors};
        delete competitorsNew[action.competitorId];
        return {
            ...state,
            competitors: competitorsNew,
        };
    },

    [RESET_COMPETITORS](state) {
        return {
            ...state,
            competitors: undefined,
        };
    },
});
