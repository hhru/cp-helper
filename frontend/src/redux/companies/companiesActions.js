import axios from 'axios';
import {EMPLOYERS_HH_API_URL, CP_HELPER_TRACKED_URL} from 'utils/constants';

import createNotification from 'utils/notifications';

export const FETCH_COMPANY = 'FETCH_COMPANY';
export const CHOOSE_COMPANY = 'CHOOSE_COMPANY';
export const RESET_COMPANY = 'RESET_COMPANY';
export const FETCH_TRACKED_COMPANIES_SUCCESS = 'FETCH_TRACKED_COMPANIES_SUCCESS';
export const FETCH_TRACKED_COMPANIES_BEGIN = 'FETCH_TRACKED_COMPANIES_BEGIN';
export const FETCH_TRACKED_COMPANIES_FAILURE = 'FETCH_TRACKED_COMPANIES_FAILURE';

export const fetchCompanyAction = (companies) => {
    return {
        type: FETCH_COMPANY,
        companies,
    };
};

export const chooseCompanyAction = (companyId, companyName) => {
    return {
        type: CHOOSE_COMPANY,
        companyId,
        companyName,
    };
};

export const resetCompanyAction = () => {
    return {
        type: RESET_COMPANY,
    };
};

export const fetchTrackedCompaniesBeginAction = () => {
    return {
        type: FETCH_TRACKED_COMPANIES_BEGIN,
    };
};

export const fetchTrackedCompaniesSuccessAction = (trackedCompanies) => {
    return {
        type: FETCH_TRACKED_COMPANIES_SUCCESS,
        trackedCompanies,
    };
};
export const fetchTrackedCompaniesFailureAction = () => {
    return {
        type: FETCH_TRACKED_COMPANIES_FAILURE,
    };
};

export function fetchCompany(companyName) {
    const url = `${EMPLOYERS_HH_API_URL}?text=${encodeURIComponent(companyName)}`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                dispatch(fetchCompanyAction(res.data.items));
            });
    };
}

export function chooseCompany(companyId, companyName) {
    return (dispatch) => {
        dispatch(chooseCompanyAction(companyId, companyName));
    };
}

export function resetCompany() {
    return (dispatch) => {
        dispatch(resetCompanyAction());
    };
}

export function getCompanyNameById(companyId) {
    const url = `${EMPLOYERS_HH_API_URL}/${companyId}`;
    return (dispatch) => {
        axios.get(url)
            .then((res) => {
                if (res.data.name) {
                    dispatch(chooseCompanyAction(companyId, res.data.name));
                }
            });
    };
}

export function fetchTrackedCompanies() {
    const url = `${CP_HELPER_TRACKED_URL}`;
    return (dispatch) => {
        dispatch(fetchTrackedCompaniesBeginAction());
        axios.get(url)
            .then((res) => {
                dispatch(fetchTrackedCompaniesSuccessAction(res.data.trackedEmployerMapDto.employers));
            })
            .catch(() => {
                createNotification('error', 'Сервер недоступен', 'Ошибка');
                dispatch(fetchTrackedCompaniesFailureAction());
            });
    };
}
