import axios from 'axios';
import {CP_HELPER_REPORT_URL} from 'utils/constants';
import createNotification from 'utils/notifications';

export const FETCH_SERVICES_BEGIN = 'FETCH_SERVICES_BEGIN';
export const FETCH_SERVICES_SUCCESS = 'FETCH_SERVICES_SUCCESS';
export const FETCH_SERVICES_FAILURE = 'FETCH_SERVICES_FAILURE';
export const RESET_SERVICES = 'RESET_SERVICES';

export const fetchServicesBeginAction = () => {
    return {
        type: FETCH_SERVICES_BEGIN,
    };
};

export const fetchServicesSuccessAction = ({services, date}) => {
    return {
        type: FETCH_SERVICES_SUCCESS,
        services,
        date,
    };
};
export const fetchServicesFailureAction = () => {
    return {
        type: FETCH_SERVICES_FAILURE,
    };
};

export const resetServicesAction = () => {
    return {
        type: RESET_SERVICES,
    };
};

export function generateURL(companyId, competitors, date, areaId, profAreaId, typeFile) {
    let url = CP_HELPER_REPORT_URL;
    if (typeFile) {
        url += `/${typeFile}`;
    }
    url += '?';
    if (companyId) {
        url += `employerId=${companyId}&`;
    }
    if (competitors) {
        url += `employerId=${Object.keys(competitors).join('&employerId=')}&`;
    }
    if (date) {
        url += `startDate=${date.startDate}&endDate=${date.endDate}&`;
    }
    if (areaId) {
        url += `areaId=${areaId}&`;
    }
    if (profAreaId) {
        url += `profAreaId=${profAreaId}`;
    }
    return url;
}

export function fetchServices(companyId, competitors, date, areaId, profAreaId) {

    const url = generateURL(companyId, competitors, date, areaId, profAreaId);
    return (dispatch) => {
        dispatch(fetchServicesBeginAction());
        axios.get(url)
            .then((res) => {
                dispatch(fetchServicesSuccessAction({services: res.data.services_by_employer, date}));
            })
            .catch(() => {
                createNotification('error', 'Введены некорректные даты', 'Ошибка');
                dispatch(fetchServicesFailureAction());
            });
    };
}

export function resetServices() {
    return (dispatch) => {
        dispatch(resetServicesAction());
    };
}
