import React from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';

import './CorporateOffer.css';

const CorporateOffer = ({ openCompetitorsList, competitors}) => {

    return (
        <section className="corporate-offer-section">
            <div className="corporate-offer-section__offer">
                <Heading level={3}>Корпоративное предложение</Heading>
            </div>
            { competitors && Object.values(competitors).map((el) => <div key={el.id}>{el.name}</div>) }
            <div className="corporate-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

CorporateOffer.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    competitors: PropTypes.object,
};

export default connect(
    (state) => ({
        competitors: state.competitors.competitors,
    })
)(CorporateOffer);
