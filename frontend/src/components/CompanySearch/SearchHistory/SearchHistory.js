import React from 'react';
import PropTypes from 'prop-types';

import Button from 'components/Button/Button';
import SearchHistoryItem from 'components/CompanySearch/SearchHistory/SearchHistoryItem';

import './SearchHistory.css';

const SearchHistory = ({history, onChooseCompany, onClearHistory}) => (
    <div className="search-history">
        <div className="search-history__title">
            История поиска
            <Button onClick={onClearHistory} outline>Очистить историю</Button>
        </div>
        <div className="search-history__header">
            <div className="search-history__header-item">
                Компания
            </div>
            <div className="search-history__header-item">
                Регион
            </div>
        </div>
        {Object.entries(history).map(([id, item]) => (
            <SearchHistoryItem key={id}
                onChooseCompany={() => onChooseCompany({companyId: item.companyId,
                                                        companyName: item.companyName,
                                                        areaId: item.areaId,
                                                        areaName: item.areaName})}
                name={item.companyName}
                area={item.areaName}/>
        ))}
    </div>
);

SearchHistory.propTypes = {
    history: PropTypes.object,
    onChooseCompany: PropTypes.func,
    onClearHistory: PropTypes.func,
};

export default SearchHistory;
