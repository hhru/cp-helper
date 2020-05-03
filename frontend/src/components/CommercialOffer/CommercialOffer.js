import React, {useEffect} from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';

import {initProfAreas} from 'redux/profAreas/profAreasActions';

import './CommercialOffer.css';

const CommercialOffer = ({ openCompetitorsList, competitors, profAreas, initProfAreas, services}) => {

    useEffect(() => {
        if (!profAreas) {
            initProfAreas();
        }
    }, []);

    return (
        <section className="commercial-offer-section">
            <div className="commercial-offer-section__offer">
                <Heading level={3}>Коммерческое предложение</Heading>
            </div>
            { competitors && Object.values(competitors).map((el) => <div key={el.id}>{el.name}</div>) }
            {services && Object.keys(services).map((el) =>
                services[el].map((elem) =>
                    <div key={elem.employerId}>
                        {'|'}{elem.employerId}
                        {'|'}{elem.serviceCode}
                        {'|'}{elem.serviceName}
                        {'|'}{elem.serviceAreaId}
                        {'|'}{elem.serviceProfArea}
                        {'|'}{elem.responseCount}
                        {'|'}{elem.responsePerService}{'|'}
                    </div>
            ))}
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
    initProfAreas: PropTypes.func,
    services: PropTypes.object,
};

export default connect(
    (state) => ({
        competitors: state.competitors.competitors,
        profAreas: state.profAreas.profAreas,
        services: state.services.services,
    }),
    {
        initProfAreas,
    }
)(CommercialOffer);
