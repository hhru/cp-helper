import axios from 'axios';
import {EMPLOYERS_HH_API_URL} from 'utils/constants';

export const FETCH_COMPANY = 'FETCH_COMPANY';
export const CHOOSE_COMPANY = 'CHOOSE_COMPANY';
export const RESET_COMPANY = 'RESET_COMPANY';

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
