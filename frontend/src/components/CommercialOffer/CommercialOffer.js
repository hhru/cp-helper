import React from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';

import './CommercialOffer.css';

const CommercialOffer = ({ openCompetitorsList, competitors, profAreas}) => {

    return (
        <section className="commercial-offer-section">
            <div className="commercial-offer-section__offer">
                <Heading level={3}>Коммерческое предложение</Heading>
            </div>
            { competitors && Object.values(competitors).map((el) => <div key={el.id}>{el.name}</div>) }
            { profAreas && Object.keys(profAreas).map((el) => <div key={el}>{profAreas[el]}</div>) }
            <div className="commercial-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

CommercialOffer.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    competitors: PropTypes.object,
    profAreas: PropTypes.object,
};

export default connect(
    (state) => ({
        competitors: state.competitors.competitors,
        profAreas: state.profAreas.profAreas,
    })
)(CommercialOffer);
