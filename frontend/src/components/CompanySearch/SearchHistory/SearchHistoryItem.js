import React from 'react';
import PropTypes from 'prop-types';

import './SearchHistoryItem.css';

const SearchHistoryItem = ({name, area, onChooseCompany}) => {
    return (
        <div className="search-history-item" onClick={onChooseCompany}>
            <div className="search-history-item-company">
                {name}
            </div>
            <div className="search-history-item-area">
                {area}
            </div>
        </div>
    );
};

SearchHistoryItem.propTypes = {
    name: PropTypes.string,
    area: PropTypes.string,
    onChooseCompany: PropTypes.func,
};

export default SearchHistoryItem;
