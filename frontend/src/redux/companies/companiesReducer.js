import {createReducer} from 'redux-create-reducer';

import {FETCH_COMPANY, CHOOSE_COMPANY, RESET_COMPANY, FETCH_TRACKED_COMPANIES_BEGIN, FETCH_TRACKED_COMPANIES_FAILURE, FETCH_TRACKED_COMPANIES_SUCCESS, DELETE_TRACKED_COMPANY, ADD_TRACKED_COMPANY} from './companiesActions';

export const initialState = {
    companyId: undefined,
    companyName: undefined,
    companies: undefined,
    trackedCompanies: undefined,
    isLoading: false,
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
            companyName: action.companyName,
        };
    },

    [RESET_COMPANY](state) {
        return {
            ...state,
            companyId: initialState.companyId,
            companyName: initialState.companyName,
        };
    },

    [FETCH_TRACKED_COMPANIES_BEGIN](state) {
        return {
            ...state,
            trackedCompanies: initialState.trackedCompanies,
            isLoading: true,
        };
    },

    [FETCH_TRACKED_COMPANIES_SUCCESS](state, action) {
        return {
            ...state,
            trackedCompanies: action.trackedCompanies,
            isLoading: false,
        };
    },

    [FETCH_TRACKED_COMPANIES_FAILURE](state) {
        return {
            ...state,
            isLoading: false,
        };
    },

    [DELETE_TRACKED_COMPANY](state, action) {
        const trackedCompaniesNew = state.trackedCompanies.filter((el) => el.employerId !== action.companyId);
        return {
            ...state,
            trackedCompanies: trackedCompaniesNew,
        };
    },

    [ADD_TRACKED_COMPANY](state, action) {
        return {
            ...state,
            trackedCompanies: [...state.trackedCompanies, {employerId: Number(action.companyId), employerName: action.companyName}],
        };
    },
});
