import {createReducer} from 'redux-create-reducer';

import {FETCH_AREA, CHOOSE_AREA} from './areaSearchAction';


export const initialState = {
    areaId: undefined,
    areas: undefined
};

export const areaSearchReducer = createReducer(initialState, {

    [FETCH_AREA](state, action) {
        return {
            ...state,
            areas: action.filteredAreas,
        }
    },
    [CHOOSE_AREA](state, action) {
        return {
            ...state,
            areaId: action.areaId,
        }
    },
});