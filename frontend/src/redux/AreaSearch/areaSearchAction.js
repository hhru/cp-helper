import axios from 'axios';

export const FETCH_AREA = 'FETCH_AREA';
export const CHOOSE_AREA = 'CHOOSE_AREA';

export const fetchAreaAction = (areaName, plainAreas) => {
    let filteredAreas = plainAreas.filter(
        area => 
            area.name.toUpperCase().indexOf(areaName.toUpperCase()) != -1
        );
    return {
        type: FETCH_AREA,
        filteredAreas,
    };
} 

export const chooseAreaAction = (areaId) => {
    return {
        type: CHOOSE_AREA,
        areaId,
    };
};

export function fetchArea(areaName, plainAreas) {
    return (dispatch) => {
        dispatch(fetchAreaAction(areaName, plainAreas));
    }
}

export function chooseArea(areaId) {
    return (dispatch) => {
        dispatch(chooseAreaAction(areaId));
    };
}
