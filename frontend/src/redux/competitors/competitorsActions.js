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

    return (dispatch) => {
        axios.get('/employer/' + companyId + '/competitors').then(competitorsIds => 
            Promise.all(
                competitorsIds.data.competitorsIds.map(
                    companyId => axios.get(URL_API + companyId),
                )).then(
                (values) => {
                    let competitors = {};
                    values.forEach( (el) => {
                        let logo = el.data.logo_urls ? el.data.logo_urls[90] : null;
                        competitors[el.data.id] = {id: el.data.id, name: el.data.name, logo: logo}
                    })
                    dispatch(updateCompetitorsAction(competitors));
                })
        )
    };
}

export function deleteCompetitor(competitors, deleteId, companyId) {

    axios.delete('/employer/' + companyId + '/competitors', {
        data: {
            "competitorId": deleteId,
            "areaId": "113"}
    })
    let competitorsNew = {...competitors};
    delete competitorsNew[deleteId];
    return (dispatch) => {
        dispatch(updateCompetitorsAction(competitorsNew));
    };
}

export function addCompetitor(competitors, addId, companyId) {
    
    axios.post('/employer/' + companyId + '/competitors', {
        "competitorId": addId,
        "areaId": "113"
    })
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
