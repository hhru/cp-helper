import React, {Fragment, useState} from 'react';

import Header from './Header/Header';
import CompanySearch from './CompanySearch/CompanySearch';
import CompetitorsList from './CompetitorsList/CompetitorsList';
import Footer from './Footer/Footer';
import Tab from './Tab/Tab';

import './MainComponent.css';

export const COMPANY_SEARCH = 'COMPANY_SEARCH';
export const COMPETITORS_LIST = 'COMPETITORS_LIST';


const MainComponent = () => {

    const [tab, setTab] = useState(COMPANY_SEARCH);

    const openCompanySearch = () => {
        setTab(COMPANY_SEARCH);
    };

    const openCompetitorsList = () => {
        setTab(COMPETITORS_LIST);
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
                />
            </Tab>
            <Footer/>
        </Fragment>
    );
};

export default MainComponent;
