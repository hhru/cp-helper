import {createReducer} from 'redux-create-reducer';

import {FFETCH_SERVICES_BEGIN, FFETCH_SERVICES_SUCCESS, FFETCH_SERVICES_FAILURE} from './servicesActions';

export const initialState = {
    services: undefined,
    isLoading: false,
};

export const servicesReducer = createReducer(initialState, {

    [FFETCH_SERVICES_BEGIN](state) {
        return {
            ...state,
            isLoading: true,
        };
    },

    [FFETCH_SERVICES_SUCCESS](state, action) {
        return {
            ...state,
            services: action.services,
            isLoading: false,
        };
    },

    [FFETCH_SERVICES_FAILURE](state) {
        return {
            ...state,
            isLoading: false,
        };
    },
});
