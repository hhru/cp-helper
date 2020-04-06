import axios from 'axios';

export const UPDATE_COMPETITORS = 'UPDATE_COMPETITORS';

const URL_API = 'https://api.hh.ru/employers/';

export const updateCompetitorsAction = (competitors) => {
    return {
        type: UPDATE_COMPETITORS,
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
                    let logo = el.data.logo_urls ? el.data.logo_urls[90] : null;
                    competitors[el.data.id] = {id: el.data.id, name: el.data.name, logo: logo}
                })
                dispatch(updateCompetitorsAction(competitors));
            });
    };
}

export function deleteCompetitor(competitors, deleteId) {
    let competitorsNew = {...competitors};
    delete competitorsNew[deleteId];
    return (dispatch) => {
        dispatch(updateCompetitorsAction(competitorsNew));
    };
}

export function addCompetitor(competitors, addId) {
    let competitorsNew = {...competitors};
    return (dispatch) => {
        axios.get(URL_API + addId).then( (el) => {
            let logo = el.data.logo_urls ? el.data.logo_urls[90] : null;
            competitorsNew[el.data.id] = {id: el.data.id, name: el.data.name, logo: logo};
            dispatch(updateCompetitorsAction(competitorsNew));
        }
    )};
}

export function resetCompetitors() {
    return (dispatch) => {
        dispatch(updateCompetitorsAction(undefined));
    };
}
