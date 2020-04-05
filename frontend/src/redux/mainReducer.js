import {combineReducers} from 'redux';

import {searchReducer} from './search/searchReducer';
import {areaSearchReducer} from './AreaSearch/areaSearchReducer'

export default combineReducers({
    search: searchReducer,
    areaSearch: areaSearchReducer,
});
