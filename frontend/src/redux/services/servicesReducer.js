import {createReducer} from 'redux-create-reducer';

import {FETCH_SERVICES} from './servicesActions';

export const initialState = {
    services: undefined,
};

export const servicesReducer = createReducer(initialState, {

    [FETCH_SERVICES](state, action) {
        return {
            ...state,
            services: action.services,
        };
    },
});
