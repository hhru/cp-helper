import {createReducer} from 'redux-create-reducer';

import {FILTER_AREA, CHOOSE_AREA, INIT_AREAS, RESET_AREA} from './areasAction';

export const initialState = {
    areaId: undefined,
    areaName: undefined,
    filteredAreas: undefined,
    plainAreas: undefined,
};

export const areasReducer = createReducer(initialState, {

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
            areaName: action.areaName,
        };
    },
    [INIT_AREAS](state, action) {
        return {
            ...state,
            plainAreas: action.plainAreas,
        };
    },
    [RESET_AREA](state) {
        return {
            ...state,
            areaId: initialState.areaId,
            areaName: initialState.areaName,
        };
    },
});
