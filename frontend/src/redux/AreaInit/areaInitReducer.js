import {createReducer} from 'redux-create-reducer';

/* import {INIT_AREAS} from './areaInitAction'; */
/* import {initArea} from './areaInitAction'; */
const INIT_AREAS = 'INIT_AREAS';

export const initialState = {
    plainAreas: []
};

export const areaInitReducer = createReducer(initialState, {

    [INIT_AREAS](state, action) {
        return {
            ...state,
            plainAreas: action.plainAreas,
        }
    }
});
