import React from 'react';
import ReactDOM from 'react-dom';
import {createStore, applyMiddleware} from 'redux';
import {Provider} from 'react-redux';
import thunk from 'redux-thunk';

import MainComponent from './components/MainComponent';

import mainReducer from './redux/mainReducer';


const store = createStore(mainReducer, applyMiddleware(thunk));

ReactDOM.render(
    <Provider store={store}>
        <MainComponent />
    </Provider>,
    document.getElementById('root'));
