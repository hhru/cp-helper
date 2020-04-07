import React, { useEffect, Fragment, useState } from 'react';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import CloseIcon from 'components/Icons/CloseIcon';
import Competitor from './Competitor/Competitor';
import AddIcon from 'components/Icons/AddIcon';
import Loader from 'components/Loader/Loader';
import Search from 'components/Search/Search';
import ChooseCompanyButton from '../ChooseCompnayButton/ChooseCompnayButton';

import { COMPETITORS_LIST } from 'components/MainComponent';

import { fetchCompetitors, deleteCompetitor, addCompetitor } from 'redux/competitors/competitorsActions';
import { fetchCompany, chooseCompetitor } from 'redux/search/searchActions';

import './CompetitorsList.css';


const CompetitorsList = ({ 
    currentTab,
    openCompanySearch,
    competitors,
    companyId,
    fetchCompetitors,
    openCorporateOffer,
    competitorId,
    deleteCompetitor,
    chooseCompetitor,
    addCompetitor,
    fetchCompany,
    companies
}) => {

    if (currentTab !== COMPETITORS_LIST) {
        return null;
    }

    const [searchOpen, setSearchOpen] = useState(false);

    useEffect( () => {
        if (!competitors) {
            fetchCompetitors(companyId);
        }
    }, []);

    const clickSearch = () => {
        addCompetitor(competitors, competitorId);
        setSearchOpen(false);
        chooseCompetitor(undefined);
    };

    const clickAdd = () => {
        setSearchOpen(true);
    }

    const clickClose = () => {
        setSearchOpen(false);
    }

    return (
        <section className="competitors-list-section">
            {!competitors && 
                <div className="competitors-list-section__loader">
                    <Loader/>
                </div>
            }
            {competitors && 
                <Fragment>
                    <div className="competitors-list-section__competitors">
                        { Object.values(competitors).map(el =>
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
                        <ButtonIcon onClick={clickAdd}>
                            <AddIcon size={30}/>
                        </ButtonIcon>
                    </div>
                </Fragment>
            }
            {searchOpen && 
                <div className="background-section">
                    <div className="competitors-list-section__search">
                        <Search 
                            fetch={fetchCompany}
                            items={companies}
                            choose={chooseCompetitor}
                            payload={competitorId}
                            placeholderText={'Введите название компании'}
                        >
                        <ChooseCompanyButton
                            onClick={clickSearch}
                            payload={competitorId}
                        />
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
                <Button onClick={openCorporateOffer}>К следующему шагу</Button>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
        competitorId: state.search.competitorId,
        competitors: state.competitors.competitors,
        companies: state.search.companies
    }),
    {
        fetchCompany,
        fetchCompetitors,
        chooseCompetitor,
        deleteCompetitor,
        addCompetitor,
    },
)(CompetitorsList);
