import {combineReducers} from 'redux';

import {companiesReducer} from './search/companiesReducer';
import {competitorsReducer} from './competitors/competitorsReducer';
import {areaSearchReducer} from './areas/areasReducer';


export default combineReducers({
    companies: companiesReducer,
    competitors: competitorsReducer,
    areas: areaSearchReducer,
});
