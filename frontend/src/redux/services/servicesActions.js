import axios from 'axios';
import {CP_HELPER_REPORT_URL} from 'utils/constants';
import createNotification from 'utils/notifications';

export const FETCH_SERVICES = 'FETCH_SERVICES';
export const RESET_SERVICES = 'RESET_SERVICES';

export const fetchServicesAction = (services, date) => {
    return {
        type: FETCH_SERVICES,
        services,
        date,
    };
};

export const resetServicesAction = () => {
    return {
        type: RESET_SERVICES,
    };
};

export function fetchServices(companyId, competitors, date, areaId, profAreaId) {

    let url = `${CP_HELPER_REPORT_URL}?employerId=${companyId}`;
    if (competitors) {
        url += `&employerId=${Object.keys(competitors).join('&employerId=')}`;
    }
    url += `&startDate=${date.startDate}&endDate=${date.endDate}`;
    if (areaId) {
        url += `&areaId=${areaId}`;
    }
    if (profAreaId) {
        url += `&profAreaId=${profAreaId}`;
    }
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                dispatch(fetchServicesAction(res.data.services_by_employer, date));
            })
            .catch(() => {
                createNotification('error', 'Введены некорректные даты', 'Ошибка');
            });
    };
}

export function resetServices() {
    return (dispatch) => {
        dispatch(resetServicesAction());
    };
}
