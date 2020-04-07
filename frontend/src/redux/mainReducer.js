import {combineReducers} from 'redux';

import {searchReducer} from './search/searchReducer';
import {competitorsReducer} from './competitors/competitorsReducer';
import {areaSearchReducer} from './areas/areaSearchReducer';



export default combineReducers({
    search: searchReducer,
    competitors: competitorsReducer,
    areas: areaSearchReducer,
});
