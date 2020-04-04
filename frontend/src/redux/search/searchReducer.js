import {createReducer} from 'redux-create-reducer';

import {FETCH_COMPANY, CHOOSE_COMPANY, FETCH_AREA, CHOOSE_AREA} from './searchActions';


export const initialState = {
    companyId: undefined,
    companies: undefined,
    areaId: undefined,
    areas: undefined
};

export const searchReducer = createReducer(initialState, {

    [FETCH_COMPANY](state, action) {
        return {
            ...state,
            companies: action.companies,
        };
    },
    [CHOOSE_COMPANY](state, action) {
        return {
            ...state,
            companyId: action.companyId,
        };
    },
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
