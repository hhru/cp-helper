import React, {useEffect, useState} from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import Heading from 'components/Heading/Heading';
import Search from 'components/Search/Search';
import Loader from 'components/Loader/Loader';
import ServiciesList from 'components/ServiciesList/ServiciesList';
import ServicesDownload from 'components/CommercialOffer/ServicesDownload/ServicesDownload';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import DeleteIcon from 'components/Icons/DeleteIcon';

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
    isLoading,
    companyName,
    plainAreas,
}) => {

    const [choosenAreaId, setChoosenAreaId] = useState(null);
    const [choosenProfAreaId, setChoosenProfAreaId] = useState(null);

    const [filteredProfAreas, setFilteredProfAreas] = useState([]);

    useEffect(() => {
        if (!profAreas) {
            initProfAreas();
        }
    }, []);

    useEffect(() => {
        fetchServices(companyId, competitors, date, choosenAreaId, choosenProfAreaId);
    }, [choosenAreaId, choosenProfAreaId]);

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
            <div className="commercial-offer-section__header">
                <div>
                    {`Фильтр услуг для компании ${companyName}`}<br />
                    <div className="commercial-offer-section__filter-info">
                        {"- по области: "}
                        {(plainAreas && choosenAreaId) ?
                            <>
                            {plainAreas[choosenAreaId].name}
                            <ButtonIcon onClick={() => setChoosenAreaId(null)}>
                                <DeleteIcon size={13}/>
                            </ButtonIcon>
                            </>
                            :
                            'не определена'
                        }<br />
                    </div>
                    <div className="commercial-offer-section__filter-info">
                        {"- по проф. области: "}
                        {(profAreas && choosenProfAreaId) ?
                            <>
                            {profAreas[choosenProfAreaId].name}
                            <ButtonIcon onClick={() => setChoosenProfAreaId(null)}>
                                <DeleteIcon size={13}/>
                            </ButtonIcon>
                            </>
                            :
                            'не определена'
                        }
                    </div>
                </div>
                <ServicesDownload
                    choosenAreaId={choosenAreaId}
                    choosenProfAreaId={choosenProfAreaId}
                />
            </div>
            <div className="commercial-offer-section__filter">
                <Search
                    fetch={filterArea}
                    items={filteredAreas}
                    choose={setChoosenAreaId}
                    payload={choosenAreaId}
                    placeholderText={'Выберите регион'}
                    id={"area"}
                    initialValue={choosenAreaId ? plainAreas[choosenAreaId].name : ""}
                />
                <Search
                    fetch={filterProfAreas}
                    items={filteredProfAreas}
                    choose={setChoosenProfAreaId}
                    payload={choosenProfAreaId}
                    placeholderText={'Выберите специализацию'}
                    id={"profArea"}
                    initialValue={choosenProfAreaId ? profAreas[choosenProfAreaId].name : ""}
                />
            </div>
            {isLoading ? (
                <div className="competitors-list-section__loader">
                    <Loader/>
                </div>) : (
                <div className="commercial-offer-section__table">
                    <ServiciesList
                        services={services}
                        competitors={competitors}
                        companyName={companyName}
                        companyId={companyId}
                    />
                </div>
                )
            }
            <div className="commercial-offer-section__btn">
                <Button onClick={openCompetitorsList} outline>К предыдущему шагу</Button>
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
    isLoading: PropTypes.bool,
    companyName: PropTypes.string,
    plainAreas: PropTypes.object,
};

export default connect(
    (state) => ({
        profAreas: state.profAreas.profAreas,
        services: state.services.services,
        filteredAreas: state.areas.filteredAreas,
        companyId: state.companies.companyId,
        competitors: state.competitors.competitors,
        date: state.services.date,
        isLoading: state.services.isLoading,
        companyName: state.companies.companyName,
        plainAreas: state.areas.plainAreas,
    }),
    {
        initProfAreas,
        filterArea,
        fetchServices,
    }
)(CommercialOffer);
