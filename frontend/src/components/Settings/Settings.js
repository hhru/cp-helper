import React, {useState, useEffect} from 'react';
import PropTypes from "prop-types";
import {connect} from 'react-redux';

import ContentWrapper from 'components/ContentWrapper/ContentWrapper';
import Heading from 'components/Heading/Heading';
import Button from 'components/Button/Button';
import AddIcon from 'components/Icons/AddIcon';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import PopupSearch from 'components/Search/PopupSearch/PopupSearch';
import TrackedCompanySearch from 'components/Settings/TrackedCompanySearch/TrackedCompanySearch';
import TrackedCompaniesList from 'components/Settings/TrackedCompaniesList/TrackedCompaniesList';
import SettingsWeights from 'components/Settings/SettingsWeights/SettingsWeights';
import ColumnsWrapper from 'components/ColumnsWrapper/ColumnsWrapper';
import Columns from 'components/Columns/Columns';

import {fetchTrackedCompanies, addTrackedCompany, fetchCompany} from 'redux/companies/companiesActions';

import './Settings.css';

const Settings = ({closeSettings, fetchTrackedCompanies, fetchCompany, companies, addTrackedCompany}) => {

    const [searchIsOpen, setSearchIsOpen] = useState(false);
    const [trackedCompany, setTrackedCompany] = useState({id: null, name: null});

    useEffect(() => {
        fetchTrackedCompanies();
    }, []);

    const chooseTrackedCompany = (id, name) => {
        setTrackedCompany({id, name});
    };

    const clickSearch = () => {
        addTrackedCompany(trackedCompany.id, trackedCompany.name);
        setSearchIsOpen(false);
        setTrackedCompany({id: null, name: null});
    };

    const clickAdd = () => {
        setSearchIsOpen(true);
    };

    const clickClose = () => {
        setSearchIsOpen(false);
    };

    return (
        <section className="settings">
            <ContentWrapper>
                <div className="settings__title">
                    <Heading level={3}>Настройки</Heading>
                </div>
                <ColumnsWrapper>
                    <Columns s={2} m={4} l={8}>
                        <TrackedCompanySearch />
                        <TrackedCompaniesList />
                        <div className="settings__add">
                            <ButtonIcon onClick={clickAdd}>
                                <AddIcon size={30}/>
                            </ButtonIcon>
                        </div>
                        {searchIsOpen &&
                            <PopupSearch
                                fetch={fetchCompany}
                                items={companies}
                                choose={chooseTrackedCompany}
                                payload={trackedCompany.id}
                                placeholderText={'Введите название компании'}
                                onClick={clickSearch}
                                buttonName={'Добавить компанию'}
                                clickClose={clickClose}
                                />
                        }
                    </Columns>
                    <Columns s={2} m={2} l={4}>
                        <SettingsWeights />
                    </Columns>
                </ColumnsWrapper>
                <div className="settings__btn">
                    <Button onClick={closeSettings} outline>
                        Выход
                    </Button>
                </div>
            </ContentWrapper>
        </section>
    );
};

Settings.propTypes = {
    closeSettings: PropTypes.func,
    fetchTrackedCompanies: PropTypes.func,
    addTrackedCompany: PropTypes.func,
    fetchCompany: PropTypes.func,
    companies: PropTypes.array,
};

export default connect(
    (state) => ({
        companies: state.companies.companies,
    }),
    {
        fetchTrackedCompanies,
        fetchCompany,
        addTrackedCompany,
    }
)(Settings);
