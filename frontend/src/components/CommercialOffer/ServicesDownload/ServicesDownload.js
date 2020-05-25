import React from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import PDFIcon from 'components/Icons/PDFIcon';
import XLSIcon from 'components/Icons/XLSIcon';

import {generateURL} from 'redux/services/servicesActions';

import './ServicesDownload.css';

const ServicesDownload = ({companyId, competitors, date, choosenAreaId, choosenProfAreaId}) => {

    return (
        <div className="download">
            <a
                href={generateURL(companyId, competitors, date, choosenAreaId, choosenProfAreaId, 'xlsx')}
                target="_blank"
                rel="noopener noreferrer">
                <XLSIcon size={40}/>
            </a>
            <a
                href={generateURL(companyId, competitors, date, choosenAreaId, choosenProfAreaId, 'pdf')}
                target="_blank"
                rel="noopener noreferrer">
                <PDFIcon size={40}/>
            </a>
        </div>
    );
};

ServicesDownload.propTypes = {
    companyId: PropTypes.string,
    competitors: PropTypes.object,
    date: PropTypes.object,
    choosenAreaId: PropTypes.string,
    choosenProfAreaId: PropTypes.string,
};

export default connect(
    (state) => ({
        companyId: state.companies.companyId,
        competitors: state.competitors.competitors,
        date: state.services.date,
    }),
    {}
)(ServicesDownload);
