import axios from 'axios';

export const FETCH_COMPETITORS = 'FETCH_COMPETITORS';

export const fetchCompetitorsAction = (competitors) => {
    return {
        type: FETCH_COMPETITORS,
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
    const urlAPI = 'https://api.hh.ru/employers/';
    return (dispatch) => {
        Promise.all(
            competitorsIds.competitorsIds.map(
                companyId => axios.get(urlAPI + companyId),
            )).then(
            (values) => {
                const competitors =
                values.map(el => ({id: el.data.id, name: el.data.name, logo: el.data.logo_urls[90]}));
                dispatch(fetchCompetitorsAction(competitors));
            });
    };
}

