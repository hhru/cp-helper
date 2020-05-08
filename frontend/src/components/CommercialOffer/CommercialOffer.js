import React, {useEffect, useState} from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';
import Search from 'components/Search/Search';

import {initProfAreas} from 'redux/profAreas/profAreasActions';
import {filterArea} from 'redux/areas/areasAction';
import {fetchServices} from 'redux/services/servicesActions';

import './CommercialOffer.css';

const CommercialOffer = ({
    openCompetitorsList,
    profAreas,
    initProfAreas,
    services,
    filteredAreas,
    filterArea,
    fetchServices,
    companyId,
    competitors,
    date,
}) => {

    const [choosenAreaId, setChoosenAreaId] = useState(null);
    const [choosenProfAreaId, setChoosenProfAreaId] = useState(null);

    const [filteredProfAreas, setFilteredProfAreas] = useState([]);

    useEffect(() => {
        if (!profAreas) {
            initProfAreas();
        }
    }, []);

    const filterServices = () => {
        fetchServices(companyId, competitors, date, choosenAreaId, choosenProfAreaId);
    };

    const filterProfAreas = (value) => {
        setFilteredProfAreas(Object.values(profAreas).filter(
            (profArea) => profArea.name.toUpperCase().indexOf(value.toUpperCase()) === 0
        ));
    };

    return (
        <section className="commercial-offer-section">
            <div className="commercial-offer-section__offer">
                <Heading level={3}>Коммерческое предложение</Heading>
            </div>
            <div className="commercial-offer-section__filter">
                <Search
                    fetch={filterArea}
                    items={filteredAreas}
                    choose={setChoosenAreaId}
                    payload={choosenAreaId}
                    placeholderText={'Выберите регион'}
                />
                <Search
                    fetch={filterProfAreas}
                    items={filteredProfAreas}
                    choose={setChoosenProfAreaId}
                    payload={choosenProfAreaId}
                    placeholderText={'Выберите специализацию'}
                />
                <div className="commercial-offer-section__btn-filter">
                    <Button onClick={filterServices}>Отфильтровать услуги</Button>
                </div>
            </div>
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
            <div className="commercial-offer-section__btn">
                <Button onClick={openCompetitorsList}>К предыдущему шагу</Button>
            </div>
        </section>
    );
};

CommercialOffer.propTypes = {
    openCompetitorsList: PropTypes.func.isRequired,
    profAreas: PropTypes.object,
    initProfAreas: PropTypes.func,
    services: PropTypes.object,
    filteredAreas: PropTypes.array,
    filterArea: PropTypes.func,
    fetchServices: PropTypes.func,
    companyId: PropTypes.string,
    competitors: PropTypes.object,
    date: PropTypes.object,
};

export default connect(
    (state) => ({
        profAreas: state.profAreas.profAreas,
        services: state.services.services,
        filteredAreas: state.areas.filteredAreas,
        companyId: state.companies.companyId,
        competitors: state.competitors.competitors,
        date: state.services.date,
    }),
    {
        initProfAreas,
        filterArea,
        fetchServices,
    }
)(CommercialOffer);
