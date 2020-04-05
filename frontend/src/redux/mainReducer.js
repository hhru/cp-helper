import {combineReducers} from 'redux';

import {searchReducer} from './search/searchReducer';
import {areaSearchReducer} from './AreaSearch/areaSearchReducer'
import { areaInitReducer } from './AreaInit/areaInitReducer';

export default combineReducers({
    search: searchReducer,
    areaSearch: areaSearchReducer,
    areaInit: areaInitReducer
});
