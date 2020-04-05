import axios from 'axios';

export const INIT_AREAS = 'INIT_AREAS';

export const initAreaAction = (hierachyAreas) => {
    let plainAreas = [];
    hierachyAreas.forEach(
        function(area) {
            Array.prototype.push.apply(plainAreas, recurseAreaProcessing(area));
        }
    );
    return {
        type: INIT_AREAS,
        plainAreas,
    };
} 

function recurseAreaProcessing(area) {
    if (area.areas.length == 0) {;
        return [{"id" : area.id, "name" : area.name}];
    } else {
        let result = [{"id" : area.id, "name" : area.name}];
        area.areas.forEach(
            function(ar) {
                Array.prototype.push.apply(result, recurseAreaProcessing(ar));
            }
        );
        return result;
    }
}

export function initArea() {
    const url = `https://api.hh.ru/areas`;
    return (dispatch) => {
        console.log('initArea');
        axios.get(url)
            .then((res) => {
                dispatch(initAreaAction(res.data));
            });
    }; 
}