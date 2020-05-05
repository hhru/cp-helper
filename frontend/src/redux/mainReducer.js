import {combineReducers} from 'redux';

import {companiesReducer} from './companies/companiesReducer';
import {competitorsReducer} from './competitors/competitorsReducer';
import {profAreasReducer} from './profAreas/profAreasReducer';
import {areasReducer} from './areas/areasReducer';
import {servicesReducer} from './services/servicesReducer';

export default combineReducers({
    companies: companiesReducer,
    competitors: competitorsReducer,
    profAreas: profAreasReducer,
    areas: areasReducer,
    services: servicesReducer,
});
