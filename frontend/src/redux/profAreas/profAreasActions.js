import axios from 'axios';
import {PROFAREAS_HH_API_URL} from 'utils/constants';

export const INIT_PROFAREAS = 'INIT_PROFAREAS';

export const initProfAreasAction = (profAreas) => {
    return {
        type: INIT_PROFAREAS,
        profAreas,
    };
};

export function initProfAreas() {
    const profAreas = {};
    return (dispatch) => {
        axios.get(PROFAREAS_HH_API_URL)
            .then((res) => {
                res.data.forEach((el) => {
                    profAreas[el.id] = el.name;
                });
                dispatch(initProfAreasAction(profAreas));
            });
    };
}

