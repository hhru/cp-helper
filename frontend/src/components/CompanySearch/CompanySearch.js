import React from 'react';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from './components/SearchHistory/SearchHistory';

import {chooseCompany} from 'redux/search/searchActions';

import {COMPANY_SEARCH} from '../MainComponent';

import './CompanySearch.css';


const CompanySearch = ({ currentTab, openCompetitorsList, companyId, chooseCompany }) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }
    return (
        <section className="company-search-section">
            <Search 
                choose={chooseCompany}
                onClick={openCompetitorsList}
                disabled={companyId}
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
        chooseCompany
    }
)(CompanySearch);
