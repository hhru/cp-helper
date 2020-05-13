import {createReducer} from 'redux-create-reducer';

import {FETCH_SERVICES_BEGIN, FETCH_SERVICES_SUCCESS, FETCH_SERVICES_FAILURE, RESET_SERVICES} from './servicesActions';

export const initialState = {
    services: undefined,
    date: undefined,
    isLoading: false,
};

export const servicesReducer = createReducer(initialState, {

    [FETCH_SERVICES_BEGIN](state) {
        return {
            ...state,
            services: initialState.services,
            date: initialState.date,
            isLoading: true,
        };
    },

    [FETCH_SERVICES_SUCCESS](state, action) {
        return {
            ...state,
            services: action.services,
            date: action.date,
            isLoading: false,
        };
    },

    [FETCH_SERVICES_FAILURE](state) {
        return {
            ...state,
            isLoading: false,

    [RESET_SERVICES](state) {
        return {
            ...state,
            services: initialState.services,
            date: initialState.date,
        };
        },
    };
    },
});
