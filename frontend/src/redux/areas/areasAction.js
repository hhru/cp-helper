import axios from 'axios';
import {AREAS_HH_API_URL} from 'utils/constants';

export const FILTER_AREA = 'FILTER_AREA';
export const CHOOSE_AREA = 'CHOOSE_AREA';
export const INIT_AREAS = 'INIT_AREAS';
export const RESET_AREA = 'RESET_AREA';

export const filterAreaAction = (filteredAreas) => {
    return {
        type: FILTER_AREA,
        filteredAreas,
    };
};

export const chooseAreaAction = (areaId, areaName) => {
    return {
        type: CHOOSE_AREA,
        areaId,
        areaName,
    };
};

export const initAreaAction = (plainAreas) => {
    return {
        type: INIT_AREAS,
        plainAreas,
    };
};

export const resetAreaAction = () => {
    return {
        type: RESET_AREA,
    };
};

export function filterArea(areaName) {
    return (dispatch, getState) => {
        const plainAreas = getState().areas.plainAreas;
        let filteredAreas = Object.values(plainAreas).filter(
            (area) =>
                area.name.toUpperCase().indexOf(areaName.toUpperCase()) === 0
            );
        if (filteredAreas.length > 10) {
            filteredAreas = filteredAreas.slice(0, 9);
        }
        dispatch(filterAreaAction(filteredAreas));
    };
}

export function chooseArea(areaId, areaName) {
    return (dispatch) => {
        dispatch(chooseAreaAction(areaId, areaName));
    };
}

export function initAreas() {
    return (dispatch) => {
        axios.get(AREAS_HH_API_URL)
            .then((res) => {
                const plainAreas = getPlainAreas(res.data);
                dispatch(initAreaAction(plainAreas));
            });
    };
}

export function resetArea() {
    return (dispatch) => {
        dispatch(resetAreaAction());
    };
}

function getPlainAreas(hierachyAreas) {
    let plainAreas = {};
    hierachyAreas.forEach((area) => {
        plainAreas = {...plainAreas, ...recurseAreaProcessing(area)};
    });
    return plainAreas;
}

function recurseAreaProcessing(area) {
    if (!area.areas.length) {
        return {[area.id]: {"id": area.id, "name": area.name}};
    }
    let result = {[area.id]: {"id": area.id, "name": area.name}};
    area.areas.forEach((ar) => {
        result = {...result, ...recurseAreaProcessing(ar)};
    });
    return result;
}
