import React, {useEffect} from 'react';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from './SearchHistory/SearchHistory';
import Button from 'components/Button/Button';

import {fetchCompany, chooseCompany} from 'redux/search/searchActions';
import {fetchArea, chooseArea, initialAreas} from 'redux/areas/areaSearchAction';
import {resetCompetitors} from 'redux/competitors/competitorsActions';

import {COMPANY_SEARCH} from '../MainComponent';

import './CompanySearch.css';

const CompanySearch = ({ 
    currentTab, 
    openCompetitorsList, 
    companyId,
    companies,
    fetchCompany, 
    chooseCompany, 
    resetCompetitors,
    areaId,
    filteredAreas,
    fetchArea,
    chooseArea,
    plainAreas,
    initialAreas
}) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }

    useEffect( () => {
        if (companyId) {
            chooseCompany(undefined);
            resetCompetitors();
        }
        if (plainAreas == undefined) {
            initialAreas();
        }
    }, []);

    return (
        <section className="company-search-section">
            <div className="company-search-section__search">
                <Search
                    fetch={fetchArea}
                    items={filteredAreas}
                    choose={chooseArea}
                    payload={areaId}
                    placeholderText={'Выберите регион'}
                />
                <Search 
                    fetch={fetchCompany}
                    items={companies}
                    choose={chooseCompany}
                    payload={companyId}
                    placeholderText={'Введите название компании'}
                />
                <div className="company-search-section__btn">
                    <Button onClick={openCompetitorsList} disabled={!companyId}>Выбрать компанию</Button>
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
        companies: state.search.companies,
        areaId: state.areas.areaId,
        filteredAreas: state.areas.filteredAreas,
        plainAreas: state.areas.plainAreas
    }),
    {
        fetchCompany,
        chooseCompany,
        resetCompetitors,
        fetchArea,
        chooseArea,
        initialAreas
    }
)(CompanySearch);

