import axios from 'axios';
import {EMPLOYERS_HH_API_URL} from 'utils/constants';

export const FETCH_COMPANY = 'FETCH_COMPANY';
export const CHOOSE_COMPANY = 'CHOOSE_COMPANY';
export const CHOOSE_COMPETITOR = 'CHOOSE_COMPETITOR';

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

export function fetchCompany(companyName) {
    const url = EMPLOYERS_HH_API_URL + `?text=${encodeURIComponent(companyName)}`;
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

export function resetCompany() {
    return (dispatch) => {
        dispatch(chooseCompanyAction(undefined));
    };
}
