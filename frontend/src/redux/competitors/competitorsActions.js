import axios from 'axios';
import {EMPLOYERS_HH_API_URL, BASE_URL} from 'utils/constant.js';

export const FETCH_COMPETITORS = 'FETCH_COMPETITORS';
export const ADD_COMPETITOR = 'ADD_COMPETITOR';
export const DELETE_COMPETITOR = 'DELETE_COMPETITOR';
export const RESET_COMPETITORS = 'RESET_COMPETITORS';

const LOGO_SIZE = 90;

export const fetchCompetitorsAction = (competitors) => {
    return {
        type: FETCH_COMPETITORS,
        competitors,
    };
};

export const addCompetitorAction = (competitor) => {
    return {
        type: ADD_COMPETITOR,
        competitor,
    };
};

export const deleteCompetitorAction = (competitorId) => {
    return {
        type: DELETE_COMPETITOR,
        competitorId,
    };
};

export const resetCompetitorsAction = () => {
    return {
        type: RESET_COMPETITORS,
    };
};

export const chooseCompetitorAction = (competitorId) => {
    return {
        type: CHOOSE_COMPETITOR,
        competitorId,
    };
};

export function fetchCompetitors(companyId) {

    return (dispatch) => {
        axios.get(BASE_URL + companyId + '/competitors').then(competitorsIds => 
            Promise.all(
                competitorsIds.data.competitorsIds.map(
                    companyId => axios.get(EMPLOYERS_HH_API_URL + '/' + companyId),
                )).then(
                (values) => {
                    let competitors = {};
                    values.forEach( (el) => {
                        let logo = el.data.logo_urls ? el.data.logo_urls[LOGO_SIZE] : null;
                        competitors[el.data.id] = {id: el.data.id, name: el.data.name, logo: logo}
                    })
                    dispatch(fetchCompetitorsAction(competitors));
                })
        )
    };
}

export function deleteCompetitor(id, companyId) {

    axios.delete(BASE_URL + companyId + '/competitors', { 
        data: {
            "competitorId": id,
            "areaId": "113"
        }
    })
    return (dispatch) => {
        dispatch(deleteCompetitorAction(id));
    };
}

export function addCompetitor(id, companyId) {
    
    axios.post(BASE_URL + companyId + '/competitors', {
        "competitorId": id,
        "areaId": "113"
    })
    return (dispatch) => {
        axios.get(URL_API + id).then( (el) => {
            let logo = el.data.logo_urls ? el.data.logo_urls[LOGO_SIZE] : null;
            dispatch(addCompetitorAction({id: el.data.id, name: el.data.name, logo: logo}));
        }
    )};
}

export function resetCompetitors() {
    return (dispatch) => {
        dispatch(resetCompetitorsAction());
    };
}

export function chooseCompetitor(competitor) {
    return (dispatch) => {
        dispatch(chooseCompetitorAction(competitor));
    };
}
