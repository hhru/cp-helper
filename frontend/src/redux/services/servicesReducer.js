import {createReducer} from 'redux-create-reducer';

import {FETCH_SERVICES, RESET_SERVICES} from './servicesActions';

export const initialState = {
    services: undefined,
};

export const servicesReducer = createReducer(initialState, {

    [RESET_SERVICES](state) {
        return {
            ...state,
            services: initialState.services,
        };
    },

    [FETCH_SERVICES](state, action) {
        return {
            ...state,
            services: action.services,
        };
    },
});
