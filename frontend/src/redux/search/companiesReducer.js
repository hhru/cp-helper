import {createReducer} from 'redux-create-reducer';

import {FETCH_COMPANY, CHOOSE_COMPANY, CHOOSE_COMPETITOR} from './searchActions';


export const initialState = {
    companyId: undefined,
    competitorId: undefined,
    companies: undefined,
};

export const searchReducer = createReducer(initialState, {

    [FETCH_COMPANY](state, action) {
        return {
            ...state,
            companies: action.companies,
        };
    },
    [CHOOSE_COMPANY](state, action) {
        return {
            ...state,
            companyId: action.companyId,
        };
    },
    [CHOOSE_COMPETITOR](state, action) {
        return {
            ...state,
            competitorId: action.competitorId,
        };
    },
});
