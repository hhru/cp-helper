import React from 'react';
import {connect} from 'react-redux';

import Button from '../Button/Button';
import Search from './components/Search/Search';
import AreasSearch from './components/Search/AreasSearch';
import SearchHistory from './components/SearchHistory/SearchHistory';

import {COMPANY_SEARCH} from '../MainComponent';

import './CompanySearch.css';


const CompanySearch = ({ currentTab, openCompetitorsList, companyId, areaId }) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }
    return (
        <section className="company-search-section">
            <div className="search">
                <div className="search__select">
                    <AreasSearch/>
                </div>
                <div className="search__select">
                    <Search/>
                </div>
                <div className="search__btn">
                    <Button onClick={openCompetitorsList} disabled={!companyId && !areaId}>Показать конкурентов</Button>
                </div>
            </div>
            <div className="history">
                <SearchHistory/>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
        areaId: state.search.areaId
    }),
)(CompanySearch);
