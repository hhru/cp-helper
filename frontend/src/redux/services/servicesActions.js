import axios from 'axios';
import {CP_HELPER_REPORT_URL} from 'utils/constants';
import createNotification from 'utils/notifications';

export const FFETCH_SERVICES_BEGIN = 'FFETCH_SERVICES_BEGIN';
export const FFETCH_SERVICES_SUCCESS = 'FFETCH_SERVICES_SUCCESS';
export const FFETCH_SERVICES_FAILURE = 'FFETCH_SERVICES_FAILURE';

export const fetchServicesBeginAction = () => {
    return {
        type: FFETCH_SERVICES_BEGIN,
    };
};

export const fetchServicesSuccessAction = (services) => {
    return {
        type: FFETCH_SERVICES_SUCCESS,
        services,
    };
};
export const fetchServicesFailureAction = () => {
    return {
        type: FFETCH_SERVICES_FAILURE,
    };
};

export function fetchServices(companyId, competitors, startDate, endDate) {

    let url = `${CP_HELPER_REPORT_URL}?employerId=${companyId}`;
    if (competitors) {
        url += `&employerId=${Object.keys(competitors).join('&employerId=')}`;
    }
    url += `&startDate=${startDate}&endDate=${endDate}`;
    return (dispatch) => {
        dispatch(fetchServicesBeginAction());
        axios.get(url)
            .then((res) => {
                dispatch(fetchServicesSuccessAction(res.data.services_by_employer));
            })
            .catch(() => {
                createNotification('error', 'Введены некорректные даты', 'Ошибка');
                dispatch(fetchServicesFailureAction(undefined));

            });
    };
}

export function resetServices() {
    return (dispatch) => {
        dispatch(fetchServicesSuccessAction(undefined));
    };
}

