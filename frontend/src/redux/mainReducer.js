import {combineReducers} from 'redux';

import {searchReducer} from './search/searchReducer';
import {competitorsReducer} from './competitors/competitorsReducer';


export default combineReducers({
    search: searchReducer,
    competitors: competitorsReducer,
});
