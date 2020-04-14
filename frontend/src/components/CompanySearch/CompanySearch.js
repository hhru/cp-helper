import React, {useEffect} from 'react';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from './SearchHistory/SearchHistory';
import Button from '../Button/Button';

import {chooseCompany, resetCompany, fetchCompany } from 'redux/search/searchActions';
import {resetCompetitors} from 'redux/competitors/competitorsActions';
import {fetchArea, chooseArea, initialAreas} from 'redux/areas/areaSearchAction';

import {COMPANY_SEARCH} from '../MainComponent';

import './CompanySearch.css';


const CompanySearch = ({ 
    currentTab, 
    openCompetitorsList, 
    companyId, 
    chooseCompany, 
    resetCompany, 
    resetCompetitors,
    fetchCompany,
    companies,
    initialAreas,
    plainAreas,
    fetchArea,
    chooseArea,
    filteredAreas,
    areaId
}) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }

    useEffect( () => {
        if (companyId) {
            resetCompany();
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
                    placeholderText={'Введите название региона'}
                />
                <Search 
                    fetch={fetchCompany}
                    items={companies}
                    choose={chooseCompany}
                    payload={companyId}
                    placeholderText={'Введите название компании'}
                />
                <div className="company-search-section__btn">
                    <Button onClick={openCompetitorsList} disabled={!(companyId && areaId)}>Выбрать компанию</Button>
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
        plainAreas: state.areas.planeAreas,
        filteredAreas: state.areas.filteredAreas,
    }),
    {
        chooseCompany,
        resetCompetitors,
        resetCompany,
        fetchCompany,
        fetchArea,
        chooseArea,
        initialAreas,
    }
)(CompanySearch);
