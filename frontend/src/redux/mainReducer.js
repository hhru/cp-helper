import {combineReducers} from 'redux';

import {companiesReducer} from './companies/companiesReducer';
import {competitorsReducer} from './competitors/competitorsReducer';
import {areaSearchReducer} from './areas/areasReducer';
import {servicesReducer} from './services/servicesReducer';
import {profAreasReducer} from './profAreas/profAreasReducer';

export default combineReducers({
    companies: companiesReducer,
    competitors: competitorsReducer,
    areas: areaSearchReducer,
    services: servicesReducer,
    profAreas: profAreasReducer,
});
