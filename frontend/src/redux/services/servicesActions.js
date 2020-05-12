import axios from 'axios';
import {CP_HELPER_REPORT_URL} from 'utils/constants';
import createNotification from 'utils/notifications';

export const FFETCH_SERVICES_BEGIN = 'FFETCH_SERVICES_BEGIN';
export const FFETCH_SERVICES_SUCCESS = 'FFETCH_SERVICES_SUCCESS';
export const FFETCH_SERVICES_FAILURE = 'FFETCH_SERVICES_FAILURE';
export const RESET_SERVICES = 'RESET_SERVICES';

export const fetchServicesBeginAction = () => {
    return {
        type: FFETCH_SERVICES_BEGIN,
    };
};

export const fetchServicesSuccessAction = (services, date) => {
    return {
        type: FFETCH_SERVICES_SUCCESS,
        services,
        date,
    };
};
export const fetchServicesFailureAction = () => {
    return {
        type: FFETCH_SERVICES_FAILURE,
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
        dispatch(fetchServicesBeginAction());
        axios.get(url)
            .then((res) => {
                // eslint-disable-next-line no-console
                console.log('200', res.data);
                dispatch(fetchServicesSuccessAction(res.data.services_by_employer, date));
            })
            .catch(() => {
                // eslint-disable-next-line no-console
                console.log('error');
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
