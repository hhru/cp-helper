import React, {useEffect, useState, useRef} from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Search from 'components/Search/Search';
import SearchHistory from 'components/CompanySearch/SearchHistory/SearchHistory';
import Checkbox from 'components/Checkbox/Checkbox';
import Input from 'components/Input/Input';
import Button from 'components/Button/Button';

import {chooseCompany, resetCompany, fetchCompany, getCompanyNameById} from 'redux/companies/companiesActions';
import {resetCompetitors} from 'redux/competitors/competitorsActions';
import {filterArea, chooseArea, initAreas, resetArea} from 'redux/areas/areasAction';
import {resetServices} from 'redux/services/servicesActions';

import './CompanySearch.css';

const CompanySearch = ({
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
    getCompanyNameById,
    companyName,
    resetServices,
}) => {

    const [isSearchById, setIsSearchById] = useState(false);
    const [inputCompany, setInputCompany] = useState("");
    const initialHistory = localStorage.getItem('companySearchHistory') ?
    JSON.parse(localStorage.getItem('companySearchHistory')) :
    {};
    const [history, setHistory] = useState(initialHistory);

    const companyIdInput = useRef(null);

    useEffect(() => {
        if (companyId) {
            resetCompany();
            resetCompetitors();
            resetArea();
            resetServices();
        }
        if (!plainAreas) {
            initAreas();
        }
    }, []);

    const inputCompanyId = () => {
        chooseCompany(companyIdInput.current.value);
    };

    const changeTypeSearch = () => {
        setIsSearchById(!isSearchById);
    };

    const openNextTab = () => {
        if (!companyName) {
            getCompanyNameById(companyId);
        }
        if (!(companyId in history)) {
            const newHistory = {...history, [companyId]: companyName};
            setHistory(newHistory);
            localStorage.setItem('companySearchHistory', JSON.stringify(newHistory));
        }
        openCompetitorsList();
    };

    const handleChooseCompany = (id, name) => {
        setInputCompany(name);
        chooseCompany(id, name);
    };

    const handleClearHistory = () => {
        localStorage.removeItem("companySearchHistory");
        setHistory({});
    };

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
                        initialValue={inputCompany}
                    />
                }
                <Search
                    fetch={filterArea}
                    items={filteredAreas}
                    choose={chooseArea}
                    payload={areaId}
                    placeholderText={'Введите регион'}
                />
                <div className="company-search-section__btn">
                    <Button onClick={openNextTab} disabled={!(companyId && areaId)}>Выбрать компанию</Button>
                </div>
            </div>
            <div className="company-search-section__checkboxId">
                <Checkbox
                    labelText="Искать по идентификатору компании"
                    id="searchId"
                    onChange={changeTypeSearch}
                />
            </div>
            {!isSearchById && Object.keys(history).length > 0 && (
                <div className="history">
                <SearchHistory history={history} onChooseCompany={handleChooseCompany} onClearHistory={handleClearHistory}/>
            </div>
            )}
        </section>
    );
};

CompanySearch.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    companyId: PropTypes.string,
    chooseCompany: PropTypes.func,
    resetCompany: PropTypes.func,
    resetCompetitors: PropTypes.func,
    fetchCompany: PropTypes.func,
    companies: PropTypes.array,
    initAreas: PropTypes.func,
    plainAreas: PropTypes.object,
    filterArea: PropTypes.func,
    chooseArea: PropTypes.func,
    filteredAreas: PropTypes.array,
    areaId: PropTypes.string,
    resetArea: PropTypes.func,
    getCompanyNameById: PropTypes.func,
    companyName: PropTypes.string,
    resetServices: PropTypes.func,
};

export default connect(
    (state) => ({
        companyId: state.companies.companyId,
        companyName: state.companies.companyName,
        companies: state.companies.companies,
        areaId: state.areas.areaId,
        plainAreas: state.areas.plainAreas,
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
        getCompanyNameById,
        resetServices,
    }
)(CompanySearch);
