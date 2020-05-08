import {createReducer} from 'redux-create-reducer';

import {FETCH_SERVICES, RESET_SERVICES} from './servicesActions';

export const initialState = {
    services: undefined,
    date: undefined,
};

export const servicesReducer = createReducer(initialState, {

    [RESET_SERVICES](state) {
        return {
            ...state,
            services: initialState.services,
            date: initialState.date,
        };
    },

    [FETCH_SERVICES](state, action) {
        return {
            ...state,
            services: action.services,
            date: action.date,
        };
    },
});
