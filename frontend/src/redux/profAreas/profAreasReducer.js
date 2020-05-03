import {createReducer} from 'redux-create-reducer';

import {INIT_PROFAREAS} from './profAreasActions';

export const initialState = {
    profAreas: undefined,
};

export const profAreasReducer = createReducer(initialState, {

    [INIT_PROFAREAS](state, action) {
        return {
            ...state,
            profAreas: action.profAreas,
        };
    },
});
