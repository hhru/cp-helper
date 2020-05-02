import {combineReducers} from 'redux';

import {companiesReducer} from './companies/companiesReducer';
import {competitorsReducer} from './competitors/competitorsReducer';
import {areasReducer} from './areas/areasReducer';
import {servicesReducer} from './services/servicesReducer';

export default combineReducers({
    companies: companiesReducer,
    competitors: competitorsReducer,
    areas: areasReducer,
    services: servicesReducer,
});
