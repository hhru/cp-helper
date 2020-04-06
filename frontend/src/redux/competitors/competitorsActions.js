import axios from 'axios';

export const FETCH_COMPETITORS = 'FETCH_COMPETITORS';
export const DELETE_COMPETITOR = 'DELETE_COMPETITOR';
export const ADD_COMPETITOR = 'ADD_COMPETITOR';

const URL_API = 'https://api.hh.ru/employers/';

export const fetchCompetitorsAction = (competitors) => {
    return {
        type: FETCH_COMPETITORS,
        competitors,
    };
};

export const deleteCompetitorAction = (competitors) => {
    return {
        type: DELETE_COMPETITOR,
        competitors,
    };
};

export const addCompetitorAction = (competitors) => {
    return {
        type: ADD_COMPETITOR,
        competitors,
    };
};

export function fetchCompetitors(companyId) {
    // eslint-disable-next-line no-console
    console.log(companyId);
    const competitorsIds = {
        // eslint-disable-next-line quote-props
        "competitorsIds": [1870, 84585, 2096237, 2605703, 2624107, 1269556],
    };
    return (dispatch) => {
        Promise.all(
            competitorsIds.competitorsIds.map(
                companyId => axios.get(URL_API + companyId),
            )).then(
            (values) => {
                let competitors = {};
                values.forEach( (el) => {
                    competitors[el.data.id] = {id: el.data.id, name: el.data.name, logo: el.data.logo_urls[90]}
                })
                dispatch(fetchCompetitorsAction(competitors));
            });
    };
}

export function deleteCompetitor(competitors, deleteId) {
    let competitorsNew = {...competitors};
    delete competitorsNew[deleteId];
    return (dispatch) => {
        dispatch(deleteCompetitorAction(competitorsNew));
    };
}

export function addCompetitor(competitors, addId) {
    let competitorsNew = {...competitors};
    return (dispatch) => {
        axios.get(URL_API + addId).then( (el) => {
            competitorsNew[el.data.id] = {id: el.data.id, name: el.data.name, logo: el.data.logo_urls[90]};
            dispatch(addCompetitorAction(competitorsNew));
        }
    )};
}
