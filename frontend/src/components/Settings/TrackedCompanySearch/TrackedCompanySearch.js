import React, {useRef} from 'react';
import PropTypes from "prop-types";
import {connect} from 'react-redux';

import Input from 'components/Input/Input';
import Heading from 'components/Heading/Heading';

import {fetchTrackedCompanies} from 'redux/companies/companiesActions';

import './TrackedCompanySearch.css';

const TrackedCompanySearch = ({fetchTrackedCompanies}) => {

    const companyNameInput = useRef(null);

    const inputCompanyName = () => {
        fetchTrackedCompanies(companyNameInput.current.value);
    };

    return (
        <div className="tracked-company-search">
            <div className="tracked-company-search__title">
                <Heading level={4}>Поиск по отслеживаемым работодателям</Heading>
            </div>
            <Input
                placeholderText={'Введите название компании'}
                ref={companyNameInput}
                onChange={inputCompanyName}
            />
        </div>
    );
};

TrackedCompanySearch.propTypes = {
    fetchTrackedCompanies: PropTypes.func,
};

export default connect(
    null,
    {
        fetchTrackedCompanies,
    }
)(TrackedCompanySearch);
