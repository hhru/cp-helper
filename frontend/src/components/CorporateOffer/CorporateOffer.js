import React, { useEffect } from 'react';

import Button from 'components/Button/Button';

import {CORPORATE_OFFER} from 'components/MainComponent';

import './CorporateOffer.css';


const CorporateOffer = ({ currentTab, openCompetitorsList}) => {

    if (currentTab !== CORPORATE_OFFER) {
        return null;
    }

    return (
        <section className="corporate-offer-section">
            <div className="corporate-offer-section__offer">
                Корпоративное предложение
            </div>
            <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
        </section>
    );
};

export default CorporateOffer;
