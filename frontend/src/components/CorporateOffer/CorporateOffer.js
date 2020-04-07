import React from 'react';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';

import {CORPORATE_OFFER} from 'components/MainComponent';

import './CorporateOffer.css';


const CorporateOffer = ({ currentTab, openCompetitorsList, competitors}) => {

    if (currentTab !== CORPORATE_OFFER) {
        return null;
    }

    return (
        <section className="corporate-offer-section">
            <div className="corporate-offer-section__offer">
                <Heading level="3">Коммерческое предложение</Heading>
            </div>
            { Object.values(competitors).map(el => <div key={el.id}>{el.name}</div>) }
            <div className="corporate-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        competitors: state.competitors.competitors,
    }),
)(CorporateOffer);
