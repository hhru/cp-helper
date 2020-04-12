import React, {useEffect} from 'react';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from './SearchHistory/SearchHistory';

import {chooseCompany, resetCompany } from 'redux/search/searchActions';
import {resetCompetitors} from 'redux/competitors/competitorsActions';

import {COMPANY_SEARCH} from '../MainComponent';

import './CompanySearch.css';


const CompanySearch = ({ currentTab, openCompetitorsList, companyId, chooseCompany, resetCompany, resetCompetitors }) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }

    useEffect( () => {
        if (companyId) {
            resetCompany();
            resetCompetitors();
        }
    }, []);

    return (
        <section className="company-search-section">
            <Search 
                choose={chooseCompany}
                onClick={openCompetitorsList}
                payload={companyId}
            />
            <div className="history">
                <SearchHistory/>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
    }),
    {
        chooseCompany,
        resetCompetitors,
        resetCompany,
    }
)(CompanySearch);
