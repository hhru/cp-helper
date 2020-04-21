import React, { useEffect, Fragment, useState } from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import CloseIcon from 'components/Icons/CloseIcon';
import Competitor from 'components/CompetitorsList/Competitor/Competitor';
import AddIcon from 'components/Icons/AddIcon';
import Loader from 'components/Loader/Loader';
import Search from 'components/Search/Search';
import Heading from 'components/Heading/Heading';

import { fetchCompetitors, deleteCompetitor, addCompetitor, chooseCompetitor } from 'redux/competitors/competitorsActions';
import { fetchCompany } from 'redux/companies/companiesActions';

import './CompetitorsList.css';

const CompetitorsList = ({
    openCompanySearch,
    competitors,
    companyId,
    fetchCompetitors,
    openCommercialOffer,
    competitorId,
    deleteCompetitor,
    chooseCompetitor,
    addCompetitor,
    fetchCompany,
    companies,
    areaId,
    areaName,
    companyName,
}) => {

    const [searchIsOpen, setSearchIsOpen] = useState(false);

    useEffect(() => {
        if (!competitors) {
            fetchCompetitors(companyId);
        }
    }, []);

    const clickSearch = () => {
        addCompetitor(competitorId, companyId, areaId);
        setSearchIsOpen(false);
        chooseCompetitor(undefined);
    };

    const clickAdd = () => {
        setSearchIsOpen(true);
    };

    const clickClose = () => {
        setSearchIsOpen(false);
    };

    return (
        <section className="competitors-list-section">
            <div className="competitors-list-section__title">
                {companyName && <Heading level={4}>{`Конкуренты компании ${companyName} по области: ${areaName}`}</Heading>}
            </div>
            {!competitors &&
                <div className="competitors-list-section__loader">
                    <Loader/>
                </div>
            }
            {competitors &&
                <Fragment>
                    <div className="competitors-list-section__competitors">
                        { Object.values(competitors).map((el) =>
                            <Competitor
                                key={el.id}
                                id={el.id}
                                name={el.name}
                                logo={el.logo}
                                deleteCompetitor={() => deleteCompetitor(el.id, companyId, areaId)}
                            />
                        )}
                    </div>
                    <div className="competitors-list-section__add">
                        <ButtonIcon onClick={clickAdd}>
                            <AddIcon size={30}/>
                        </ButtonIcon>
                    </div>
                </Fragment>
            }
            {searchIsOpen &&
                <div className="background-section">
                    <div className="competitors-list-section__search">
                        <Search
                            fetch={fetchCompany}
                            items={companies}
                            choose={chooseCompetitor}
                            payload={competitorId}
                            placeholderText={'Введите название компании'}
                        >
                        <div className="search__btn">
                            <Button onClick={clickSearch} disabled={!competitorId}>Выбрать компанию</Button>
                        </div>
                        <div className="close">
                            <ButtonIcon onClick={clickClose}>
                                <CloseIcon size={30}/>
                            </ButtonIcon>
                        </div>
                        </Search>
                    </div>
                </div>
            }
            <div className="competitors-list-section__btn">
                <Button onClick={openCompanySearch}>К предыдущему шагу</Button>
                <Button onClick={openCommercialOffer}>К следующему шагу</Button>
            </div>
        </section>
    );
};

CompetitorsList.propTypes = {
    openCompanySearch: PropTypes.func.isRequired,
    competitors: PropTypes.object,
    companyId: PropTypes.string,
    fetchCompetitors: PropTypes.func,
    openCommercialOffer: PropTypes.func.isRequired,
    competitorId: PropTypes.string,
    deleteCompetitor: PropTypes.func,
    chooseCompetitor: PropTypes.func,
    addCompetitor: PropTypes.func,
    fetchCompany: PropTypes.func,
    companies: PropTypes.array,
    areaId: PropTypes.string,
    areaName: PropTypes.string,
    companyName: PropTypes.string,
};

export default connect(
    (state) => ({
        companyId: state.companies.companyId,
        competitorId: state.competitors.competitorId,
        competitors: state.competitors.competitors,
        companies: state.companies.companies,
        areaId: state.areas.areaId,
        areaName: state.areas.areaName,
        companyName: state.companies.companyName,
    }),
    {
        fetchCompetitors,
        chooseCompetitor,
        deleteCompetitor,
        addCompetitor,
        fetchCompany,
    }
)(CompetitorsList);
