import React from 'react';
import {connect} from 'react-redux';

import Button from 'components/Button/Button';

import {COMPETITORS_LIST} from 'components/MainComponent';

import './CompetitorsList.css';


const CompetitorsList = ({ currentTab, openCompanySearch, companyId, areaId }) => {

    if (currentTab !== COMPETITORS_LIST) {
        return null;
    }
    return (
        <section className="competitors-list-section">
            Список конкурентов компании: {companyId} в регионе {areaId}
            <div className="competitors-list-section__btn">
                <Button onClick={openCompanySearch}>Назад</Button>
            </div>
        </section>
    );
};

export default connect(
    state => ({
        companyId: state.search.companyId,
        areaId: state.areaSearch.areaId
    }),
)(CompetitorsList);
