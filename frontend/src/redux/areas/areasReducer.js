import {createReducer} from 'redux-create-reducer';

import {FILTER_AREA, CHOOSE_AREA, INIT_AREAS} from './areasAction';

export const initialState = {
    areaId: undefined,
    filteredAreas: undefined,
    plainAreas: undefined,
};

export const areaSearchReducer = createReducer(initialState, {

    [FILTER_AREA](state, action) {
        return {
            ...state,
            filteredAreas: action.filteredAreas,
        };
    },
    [CHOOSE_AREA](state, action) {
        return {
            ...state,
            areaId: action.areaId,
        };
    },
    [INIT_AREAS](state, action) {
        return {
            ...state,
            plainAreas: action.plainAreas,
        };
    },
});
