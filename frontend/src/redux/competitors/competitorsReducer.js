import {createReducer} from 'redux-create-reducer';
import {FETCH_COMPETITORS_BEGIN, FETCH_COMPETITORS_SUCCESS, FETCH_COMPETITORS_FAILURE, ADD_COMPETITOR, DELETE_COMPETITOR, RESET_COMPETITORS, CHOOSE_COMPETITOR} from './competitorsActions';

export const initialState = {
    competitors: undefined,
    isLoading: false,
    competitorId: undefined,
};

export const competitorsReducer = createReducer(initialState, {

    [FETCH_COMPETITORS_BEGIN](state) {
        return {
            ...state,
            competitors: initialState.competitors,
            isLoading: true,
        };
    },

    [FETCH_COMPETITORS_SUCCESS](state, action) {
        return {
            ...state,
            competitors: action.competitors,
            isLoading: false,
        };
    },

    [FETCH_COMPETITORS_FAILURE](state) {
        return {
            ...state,
            isLoading: false,
        };
    },

    [ADD_COMPETITOR](state, action) {
        const competitor = action.competitor;
        return {
            ...state,
            competitors: {...state.competitors, [competitor.id]: competitor},
        };
    },

    [DELETE_COMPETITOR](state, action) {
        const competitorsNew = {...state.competitors};
        delete competitorsNew[action.competitorId];
        return {
            ...state,
            competitors: competitorsNew,
        };
    },

    [RESET_COMPETITORS](state) {
        return {
            ...state,
            competitors: initialState.competitors,
        };
    },
    [CHOOSE_COMPETITOR](state, action) {
        return {
            ...state,
            competitorId: action.competitorId,
        };
    },
});
