import React, {useState, useEffect} from 'react';
import PropTypes from "prop-types";
import {connect} from 'react-redux';

import ContentWrapper from 'components/ContentWrapper/ContentWrapper';
import Heading from 'components/Heading/Heading';
import ColumnsWrapper from 'components/ColumnsWrapper/ColumnsWrapper';
import Button from 'components/Button/Button';
import PageNumber from 'components/Settings/PageNumber/PageNumber';
import Company from 'components/Settings/Company/Company';
import Loader from 'components/Loader/Loader';

import {fetchTrackedCompanies, deleteTrackedCompany} from 'redux/companies/companiesActions';

import './Settings.css';

const Settings = ({closeSettings, fetchTrackedCompanies, trackedCompanies, isLoading, deleteTrackedCompany}) => {

    const ITEMS_ON_PAGE = 15;
    const [slicedCompanies, setSlicedCompanies] = useState([]);
    const [pageNumbers, setPageNumbers] = useState([]);

    useEffect(() => {
        fetchTrackedCompanies();
    }, []);

    const getPageNumbers = () => {
        const numbers = [];
        for (let i = 0; i < trackedCompanies.length / ITEMS_ON_PAGE; i++) {
            numbers.push(i);
        }
        return numbers;
    };

    const sliceCompanies = (pageNumber) => {
        const startPage = pageNumber * ITEMS_ON_PAGE;
        setSlicedCompanies(trackedCompanies.slice(startPage, startPage + ITEMS_ON_PAGE > trackedCompanies.length ? trackedCompanies.length : startPage + ITEMS_ON_PAGE));
    };

    useEffect(() => {
        if (trackedCompanies) {
            setPageNumbers(getPageNumbers());
            sliceCompanies(0);
        }
    }, [trackedCompanies]);

    return (
        <div className="settings">
            <ContentWrapper>
                <div className="settings__title">
                    <Heading level={3}>Настройки</Heading>
                </div>
                <div className="settings__companies">
                    <div className="settings__title">
                        <Heading level={4}>Список отслеживаемых работодателей</Heading>
                    </div>
                    {isLoading &&
                        <div className="settings__loader">
                            <Loader/>
                        </div>
                    }
                    <ColumnsWrapper>
                        { slicedCompanies.map((el) =>
                            <Company
                                key={el.employerId}
                                name={el.employerName}
                                deleteCompany={() => deleteTrackedCompany(el.employerId)}
                            />
                        )}
                    </ColumnsWrapper>
                </div>
                { trackedCompanies && <div className="settings__pagination">
                    {(trackedCompanies.length > ITEMS_ON_PAGE) && pageNumbers.map((el) =>
                        <PageNumber
                            key={el}
                            number={el}
                            changePage={() => sliceCompanies(el)}
                        />
                    )}
                </div>}
                <Button onClick={closeSettings}>
                    Выход
                </Button>
            </ContentWrapper>
        </div>
    );
};

Settings.propTypes = {
    closeSettings: PropTypes.func,
    fetchTrackedCompanies: PropTypes.func,
    trackedCompanies: PropTypes.array,
    isLoading: PropTypes.bool,
    deleteTrackedCompany: PropTypes.func,
};

export default connect(
    (state) => ({
        trackedCompanies: state.companies.trackedCompanies,
        isLoading: state.companies.isLoading,
    }),
    {
        fetchTrackedCompanies,
        deleteTrackedCompany,
    }
)(Settings);
