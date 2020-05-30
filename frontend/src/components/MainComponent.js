import React, {Fragment, useState} from 'react';
import {NotificationContainer} from 'react-notifications';
import 'react-notifications/lib/notifications.css';

import Header from './Header/Header';
import CompanySearch from './CompanySearch/CompanySearch';
import CompetitorsList from './CompetitorsList/CompetitorsList';
import CommercialOffer from './CommercialOffer/CommercialOffer';
import Footer from './Footer/Footer';
import Tab from './Tab/Tab';
import Settings from './Settings/Settings';

import './MainComponent.css';

export const COMPANY_SEARCH = 'COMPANY_SEARCH';
export const COMPETITORS_LIST = 'COMPETITORS_LIST';
export const COMMERCIAL_OFFER = 'COMMERCIAL_OFFER';

const MainComponent = () => {

    const [tab, setTab] = useState(COMPANY_SEARCH);
    const [settingsIsOpen, setSettingsIsOpen] = useState(false);

    const openSettings = () => {
        setSettingsIsOpen(true);
    };

    const closeSettings = () => {
        setSettingsIsOpen(false);
    };

    const openCompanySearch = () => {
        setTab(COMPANY_SEARCH);
    };

    const openCompetitorsList = () => {
        setTab(COMPETITORS_LIST);
    };

    const openCommercialOffer = () => {
        setTab(COMMERCIAL_OFFER);
    };

    return (
        <Fragment>
            <Header openSettings={openSettings}/>
            {settingsIsOpen ?
                <Settings closeSettings={closeSettings}/>
                :
                <Tab currentTab={tab}>
                    {tab === COMPANY_SEARCH &&
                        <CompanySearch
                            openCompetitorsList={openCompetitorsList}
                        />}
                    {tab === COMPETITORS_LIST &&
                        <CompetitorsList
                            openCompanySearch={openCompanySearch}
                            openCommercialOffer={openCommercialOffer}
                        />}
                    {tab === COMMERCIAL_OFFER &&
                        <CommercialOffer
                            openCompetitorsList={openCompetitorsList}
                        />}
                </Tab>
            }
            <Footer/>
            <NotificationContainer/>
        </Fragment>
    );
};

export default MainComponent;
