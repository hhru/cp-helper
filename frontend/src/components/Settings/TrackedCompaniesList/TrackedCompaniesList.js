import React, {useState, useEffect} from 'react';
import PropTypes from "prop-types";
import {connect} from 'react-redux';

import Heading from 'components/Heading/Heading';
import ColumnsWrapper from 'components/ColumnsWrapper/ColumnsWrapper';
import PageNumber from 'components/Settings/TrackedCompaniesList/PageNumber/PageNumber';
import Company from 'components/Settings/TrackedCompaniesList/Company/Company';
import Loader from 'components/Loader/Loader';

import {deleteTrackedCompany} from 'redux/companies/companiesActions';

import './TrackedCompaniesList.css';

const TrackedCompaniesList = ({deleteTrackedCompany, trackedCompanies, isLoading}) => {

    const [slicedCompanies, setSlicedCompanies] = useState([]);
    const [pageNumbers, setPageNumbers] = useState([]);
    const ITEMS_ON_PAGE = 15;

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
        <div className="tracked-companies-list">
            <div className="tracked-companies-list__title">
                <Heading level={4}>Список отслеживаемых работодателей</Heading>
            </div>
            {isLoading &&
                <div className="tracked-companies-list__loader">
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
            { trackedCompanies && <div className="tracked-companies-list__pagination">
                {(trackedCompanies.length > ITEMS_ON_PAGE) && pageNumbers.map((el) =>
                    <PageNumber
                        key={el}
                        number={el}
                        changePage={() => sliceCompanies(el)}
                    />
                )}
            </div>}
        </div>
    );
};

TrackedCompaniesList.propTypes = {
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
        deleteTrackedCompany,
    }
)(TrackedCompaniesList);
