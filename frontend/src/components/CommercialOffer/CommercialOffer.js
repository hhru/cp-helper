import React, {useEffect} from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';
import Loader from 'components/Loader/Loader';
import ServiciesList from 'components/ServiciesList/ServiciesList';

import {initProfAreas} from 'redux/profAreas/profAreasActions';

import './CommercialOffer.css';

const CommercialOffer = ({ openCompetitorsList, isLoading, profAreas, initProfAreas, services}) => {

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
            {isLoading ? (
                <div className="competitors-list-section__loader">
                    <Loader/>
                </div>) : (
                <ServiciesList services={services} />
                )
            }
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
            {/* { competitors && Object.values(competitors).map((el) => <div key={el.id}>{el.name}</div>) } */}
            <div className="commercial-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

CommercialOffer.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    isLoading: PropTypes.bool,
    profAreas: PropTypes.object,
    initProfAreas: PropTypes.func,
    services: PropTypes.object,
};

export default connect(
    (state) => ({
        services: state.services.services,
        isLoading: state.services.isLoading,
        profAreas: state.profAreas.profAreas,
    }),
    {
        initProfAreas,
    }
)(CommercialOffer);
