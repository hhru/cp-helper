import axios from 'axios';
import {AREAS_HH_API_URL} from 'utils/constants';

export const FILTER_AREA = 'FILTER_AREA';
export const CHOOSE_AREA = 'CHOOSE_AREA';
export const INIT_AREAS = 'INIT_AREAS';

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

export function filterArea(areaName) {
    return (dispatch, getState) => {
        const plainAreas = getState().areas.plainAreas;
        let filteredAreas = plainAreas.filter(
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
                plainAreas.sort((a, b) => (a.name > b.name));
                dispatch(initAreaAction(plainAreas));
            });
    };
}

export function resetArea() {
    return (dispatch) => {
        dispatch(chooseAreaAction(undefined, undefined));
    };
}

function getPlainAreas(hierachyAreas) {
    let plainAreas = [];
    hierachyAreas.forEach((area) => {
        plainAreas = plainAreas.concat(recurseAreaProcessing(area));
    });
    return plainAreas;
}

function recurseAreaProcessing(area) {
    if (!area.areas.length) {
        return [{"id": area.id, "name": area.name}];
    }
    let result = [{"id": area.id, "name": area.name}];
    area.areas.forEach((ar) => {
        result = result.concat(recurseAreaProcessing(ar));
    });
    return result;
}
