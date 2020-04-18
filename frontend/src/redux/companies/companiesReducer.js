import {createReducer} from 'redux-create-reducer';

import {FETCH_COMPANY, CHOOSE_COMPANY} from './companiesActions';

export const initialState = {
    companyId: undefined,
    companies: undefined,
};

export const companiesReducer = createReducer(initialState, {

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
});
