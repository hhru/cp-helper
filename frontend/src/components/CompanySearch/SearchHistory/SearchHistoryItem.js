import React from 'react';
import PropTypes from 'prop-types';

import './SearchHistoryItem.css';

const SearchHistoryItem = ({name, onChooseCompany}) => {
    return (
        <div className="search-history-item" onClick={onChooseCompany}>
            {name}
        </div>
    );
};

SearchHistoryItem.propTypes = {
    name: PropTypes.string,
    onChooseCompany: PropTypes.func,
};

export default SearchHistoryItem;
