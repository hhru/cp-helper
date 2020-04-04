import axios from 'axios';
import store from '../../index';

export const FETCH_COMPANY = 'FETCH_COMPANY';
export const CHOOSE_COMPANY = 'CHOOSE_COMPANY';
export const FETCH_AREA = 'FETCH_AREA';
export const CHOOSE_AREA = 'CHOOSE_AREA';

export const fetchCompanyAction = (companies) => {
    return {
        type: FETCH_COMPANY,
        companies,
    };
};

export const chooseCompanyAction = (companyId) => {
    return {
        type: CHOOSE_COMPANY,
        companyId,
    };
};

export const fetchAreaAction = (hierachyAreas, areaName) => {
    let areas = [];
    hierachyAreas.forEach(
        function(area) {
            Array.prototype.push.apply(areas, recurseAreaProcessing(area));
        }
    );
    let filteredAreas = areas.filter(area => area.name.indexOf(areaName) != -1);
    return {
        type: FETCH_AREA,
        filteredAreas,
    };
} 

export function recurseAreaProcessing(area) {
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

export const chooseAreaAction = (areaId) => {
    return {
        type: CHOOSE_AREA,
        areaId,
    };
};

export function fetchCompany(companyName) {
    const url = `https://api.hh.ru/employers?text=${encodeURIComponent(companyName)}`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                dispatch(fetchCompanyAction(res.data.items));
            });
    };
}

export function chooseCompany(company) {
    return (dispatch) => {
        dispatch(chooseCompanyAction(company));
    };
}

export function fetchArea(areaName) {
    const url = `https://api.hh.ru/areas`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                dispatch(fetchAreaAction(res.data, areaName));
            });
    }; 
}

export function chooseArea(areaId) {
    return (dispatch) => {
        dispatch(chooseAreaAction(areaId));
    };
}
