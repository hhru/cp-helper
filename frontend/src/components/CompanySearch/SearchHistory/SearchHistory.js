import React from 'react';
import PropTypes from 'prop-types';

import Button from 'components/Button/Button';
import SearchHistoryItem from 'components/CompanySearch/SearchHistory/SearchHistoryItem';

import './SearchHistory.css';

const SearchHistory = ({history, onChooseCompany, onClearHistory}) => (
    <div className="search-history">
        <div className="search-history__title">История поиска</div>
        {Object.entries(history).map(([id, name]) => (
            <SearchHistoryItem key={id} onChooseCompany={() => onChooseCompany(id, name)} name={name}/>
        ))}
        <Button onClick={onClearHistory}>Очистить историю</Button>
    </div>
);

SearchHistory.propTypes = {
    history: PropTypes.object,
    onChooseCompany: PropTypes.func,
    onClearHistory: PropTypes.func,
};

export default SearchHistory;
