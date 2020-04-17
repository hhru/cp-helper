import React, {useEffect, useState, useRef} from 'react';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from './SearchHistory/SearchHistory';
import Checkbox from 'components/Checkbox/Checkbox';
import Input from 'components/Input/Input';
import Button from '../Button/Button';

import {chooseCompany, resetCompany, fetchCompany } from 'redux/companies/companiesActions';
import {resetCompetitors} from 'redux/competitors/competitorsActions';
import {filterArea, chooseArea, initAreas, resetArea} from 'redux/areas/areasAction';

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
    initAreas,
    plainAreas,
    filterArea,
    chooseArea,
    filteredAreas,
    areaId,
    resetArea,
}) => {

    if (currentTab !== COMPANY_SEARCH) {
        return null;
    }

    const [isSearchById, setIsSearchById] = useState(false);

    const companyIdInput = useRef(null);

    useEffect( () => {
        if (companyId) {
            resetCompany();
            resetCompetitors();
            resetArea();
        }
        if (!plainAreas) {
            initAreas();
        }
    }, []);

    const inputCompanyId = () => {
        chooseCompany(companyIdInput.current.value);
    }

    const changeTypeSearch = () => {
        setIsSearchById(!isSearchById);
    }

    return (
        <section className="company-search-section">
            <div className="company-search-section__search">
                { isSearchById ? 
                    <Input
                        placeholderText={'Введите идентификатор компании'}
                        ref={companyIdInput}
                        onChange={inputCompanyId}
                        inputType={"number"}
                    /> 
                    :
                    <Search 
                        fetch={fetchCompany}
                        items={companies}
                        choose={chooseCompany}
                        payload={companyId}
                        placeholderText={'Введите название компании'}
                    />
                }
                <Search 
                    fetch={filterArea}
                    items={filteredAreas}
                    choose={chooseArea}
                    payload={areaId}
                    placeholderText={'Введите название региона'}
                />
                <div className="company-search-section__btn">
                    <Button onClick={openCompetitorsList} disabled={!(companyId && areaId)}>Выбрать компанию</Button>
                </div>
            </div>
            <div className="company-search-section__checkboxId">
                <Checkbox 
                    labelText="Искать по идентификатору компании"
                    id="searchId"
                    onChange={changeTypeSearch}
                />
            </div>
            <div className="history">
                <SearchHistory/>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.companies.companyId,
        companies: state.companies.companies,
        areaId: state.areas.areaId,
        plainAreas: state.areas.planeAreas,
        filteredAreas: state.areas.filteredAreas,
    }),
    {
        chooseCompany,
        resetCompetitors,
        resetCompany,
        fetchCompany,
        filterArea,
        chooseArea,
        initAreas,
        resetArea,
    }
)(CompanySearch);
