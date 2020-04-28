import axios from 'axios';
import {EMPLOYERS_HH_API_URL, CP_HELPER_BASE_URL} from 'utils/constants';

import createNotification from 'utils/notifications';

export const FETCH_COMPETITORS = 'FETCH_COMPETITORS';
export const ADD_COMPETITOR = 'ADD_COMPETITOR';
export const DELETE_COMPETITOR = 'DELETE_COMPETITOR';
export const RESET_COMPETITORS = 'RESET_COMPETITORS';
export const CHOOSE_COMPETITOR = 'CHOOSE_COMPETITOR';

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

export function fetchCompetitors(companyId, areaId) {

    return (dispatch) => {
        axios.get(`${CP_HELPER_BASE_URL + companyId}/competitors?areaId=${areaId}`).then((competitorsIds) => {
            if (competitorsIds.data.competitorsIds.length) {
                Promise.all(
                    competitorsIds.data.competitorsIds.map(
                        (companyId) => axios.get(`${EMPLOYERS_HH_API_URL}/${companyId}`)
                    ))
                    .then(
                    (values) => {
                        const competitors = {};
                        values.forEach((el) => {
                            const logo = el.data.logo_urls ? el.data.logo_urls[LOGO_SIZE] : null;
                            competitors[el.data.id] = {id: el.data.id, name: el.data.name, logo};
                        });
                        dispatch(fetchCompetitorsAction(competitors));
                    });
            } else {
                createNotification('error', 'Данных в базе не обнаружено', 'Ошибка');
                dispatch(fetchCompetitorsAction(undefined));
            }
        })
        .catch(() => {
            createNotification('error', 'Сервер недоступен', 'Ошибка');
        });
    };
}

export function deleteCompetitor(competitorId, companyId, areaId) {

    return (dispatch) => {
        axios.delete(`${CP_HELPER_BASE_URL + companyId}/competitors`, {
            data: {
                "competitorId": competitorId,
                "areaId": areaId,
            },
        })
        .then(() => {
            createNotification('success', 'Конкурент удален');
            dispatch(deleteCompetitorAction(competitorId));
        })
        .catch(() => {
            createNotification('error', 'Сервер недоступен', 'Ошибка');
        });
    };
}

export function addCompetitor(competitorId, companyId, areaId) {

    return (dispatch) => {
        axios.post(`${CP_HELPER_BASE_URL + companyId}/competitors`, {
            "competitorId": competitorId,
            "areaId": areaId,
        })
        .then(() =>
            axios.get(`${EMPLOYERS_HH_API_URL}/${competitorId}`).then((el) => {
                const logo = el.data.logo_urls ? el.data.logo_urls[LOGO_SIZE] : null;
                createNotification('success', 'Конкурент добавлен');
                dispatch(addCompetitorAction({id: el.data.id, name: el.data.name, logo}));
            }
        )
        .catch(() => {
            createNotification('error', 'Сервер недоступен', 'Ошибка');
        })
    );
};
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
