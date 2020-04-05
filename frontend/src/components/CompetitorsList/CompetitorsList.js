import React, { useEffect } from 'react';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import Competitor from './Competitor/Competitor';
import AddIcon from 'components/Icons/AddIcon';
import Loader from 'components/Loader/Loader';

import { COMPETITORS_LIST } from 'components/MainComponent';

import { fetchCompetitors, deleteCompetitor } from 'redux/competitors/competitorsActions';

import './CompetitorsList.css';


const CompetitorsList = ({ 
    currentTab,
    openCompanySearch,
    competitors,
    companyId,
    fetchCompetitors,
    openCorporateOffer,
    deleteCompetitor,
}) => {

    if (currentTab !== COMPETITORS_LIST) {
        return null;
    }

    console.log(competitors);

    useEffect( () => {
        fetchCompetitors(companyId);
    }, []);

    return (
        <section className="competitors-list-section">
            <div className="competitors-list-section__competitors">
                { !competitors && <div className="competitors-list-section__loader">
                    <Loader/>
                </div>}
                { competitors && Object.values(competitors).map(el =>
                    <Competitor
                        key={el.id}
                        id={el.id}
                        name={el.name}
                        logo={el.logo}
                        deleteCompetitor={() => deleteCompetitor(competitors, el.id)}
                    />,
                )}
            </div>
            <div className="competitors-list-section__add">
                <ButtonIcon>
                    <AddIcon size={30}/>
                </ButtonIcon>
            </div>
            <div className="competitors-list-section__btn">
                <Button onClick={openCompanySearch}>К предыдущему шагу</Button>
                <Button onClick={openCorporateOffer}>К следующему шагу</Button>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
        competitors: state.competitors.competitors,
    }),
    {
        fetchCompetitors,
        deleteCompetitor,
    },
)(CompetitorsList);
