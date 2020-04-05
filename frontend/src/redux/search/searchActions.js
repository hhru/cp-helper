import axios from 'axios';
import store from '../../index';

export const FETCH_COMPANY = 'FETCH_COMPANY';
export const CHOOSE_COMPANY = 'CHOOSE_COMPANY';

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
