import React from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';
import ServiciesList from 'components/ServiciesList/ServiciesList';

import './CommercialOffer.css';

const CommercialOffer = ({ openCompetitorsList, services, competitors}) => {

    return (
        <section className="commercial-offer-section">
            <div className="commercial-offer-section__offer">
                <Heading level={3}>Коммерческое предложение</Heading>
            </div>
            {/* {services && Object.keys(services).map((el) =>
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
            ))} */}
            { competitors && Object.values(competitors).map((el) => <div key={el.id}>{el.name}</div>) }
            <ServiciesList services={services} />
            <div className="commercial-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

CommercialOffer.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    services: PropTypes.object,
    competitors: PropTypes.object,
};

export default connect(
    (state) => ({
        services: state.services.services,
        competitors: state.competitors.competitors,
    })
)(CommercialOffer);
