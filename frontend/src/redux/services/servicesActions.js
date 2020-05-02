import axios from 'axios';
import {CP_HELPER_REPORT_URL} from 'utils/constants';
import createNotification from 'utils/notifications';

export const FETCH_SERVICES = 'FETCH_SERVICES';

export const fetchServicesAction = (services) => {
    return {
        type: FETCH_SERVICES,
        services,
    };
};

export function fetchServices(companyId, competitors, startDate, endDate) {

    let url = `${CP_HELPER_REPORT_URL}?employerId=${companyId}`;
    if (competitors) {
        url += `&employerId=${Object.keys(competitors).join('&employerId=')}`;
    }
    url += `&startDate=${startDate}&endDate=${endDate}`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                dispatch(fetchServicesAction(res.data.services_by_employer));
            })
            .catch(() => {
                createNotification('error', 'Введены некорректные даты', 'Ошибка');
            });
    };
}

export function resetServices() {
    return (dispatch) => {
        dispatch(fetchServicesAction(undefined));
    };
}

