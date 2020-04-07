import axios from 'axios';

export const FETCH_AREA = 'FETCH_AREA';
export const CHOOSE_AREA = 'CHOOSE_AREA';
export const INIT_AREAS = 'INIT_AREAS';

export const fetchAreaAction = (filteredAreas) => {
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

export const initAreaAction = (plainAreas)  => {
    return {
        type: INIT_AREAS,
        plainAreas,
    };
};

export function fetchArea(areaName) {
    return (dispatch, getState) => {
        const plainAreas = getState().areas.plainAreas;
        const filteredAreas =  plainAreas.filter(
            area => 
                area.name.toUpperCase().indexOf(areaName.toUpperCase()) != -1
            );
        dispatch(fetchAreaAction(filteredAreas));
    }
}

export function chooseArea(areaId) {
    return (dispatch) => {
        dispatch(chooseAreaAction(areaId));
    };
}

export function initialAreas() {
    const url = `https://api.hh.ru/areas`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                const plainAreas = getPlainAreas(res.data);
                dispatch(initAreaAction(plainAreas));
            });
    };   
}

function getPlainAreas(hierachyAreas) {
    let plainAreas = [];
    hierachyAreas.forEach((area) => {
            Array.prototype.push.apply(plainAreas, recurseAreaProcessing(area));
        }
    );
    return plainAreas;
}

function recurseAreaProcessing(area) {
    if (area.areas.length == 0) {;
        return [{"id" : area.id, "name" : area.name}];
    } else {
        let result = [{"id" : area.id, "name" : area.name}];
        area.areas.forEach(
            function(ar) {
                Array.prototype.push.apply(result, recurseAreaProcessing(ar));
            }
        );
        return result;
    }
}
