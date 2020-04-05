import React, {Fragment, useState} from 'react';

import Header from './Header/Header';
import CompanySearch from './CompanySearch/CompanySearch';
import CompetitorsList from './CompetitorsList/CompetitorsList';
import CorporateOffer from './CorporateOffer/CorporateOffer';
import Footer from './Footer/Footer';
import Tab from './Tab/Tab';

import './MainComponent.css';

export const COMPANY_SEARCH = 'COMPANY_SEARCH';
export const COMPETITORS_LIST = 'COMPETITORS_LIST';
export const CORPORATE_OFFER = 'CORPORATE_OFFER';


const MainComponent = () => {

    const [tab, setTab] = useState(COMPANY_SEARCH);

    const openCompanySearch = () => {
        setTab(COMPANY_SEARCH);
    };

    const openCompetitorsList = () => {
        setTab(COMPETITORS_LIST);
    };

    const openCorporateOffer = () => {
        setTab(CORPORATE_OFFER);
    };

    return (
        <Fragment>
            <Header/>
            <Tab currentTab={tab}>
                <CompanySearch
                    currentTab={tab}
                    openCompetitorsList={openCompetitorsList}
                />
                <CompetitorsList
                    currentTab={tab}
                    openCompanySearch={openCompanySearch}
                    openCorporateOffer={openCorporateOffer}
                />
                <CorporateOffer
                    currentTab={tab}
                    openCompetitorsList={openCompetitorsList}
                />
            </Tab>
            <Footer/>
        </Fragment>
    );
};

export default MainComponent;
