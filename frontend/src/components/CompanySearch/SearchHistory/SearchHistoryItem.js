import React from 'react';
import PropTypes from 'prop-types';

import './SearchHistoryItem.css';

const SearchHistoryItem = ({id, name, onChooseCompany}) => {
    return (
        <div className="search-history-item" onClick={() => onChooseCompany(id, name)}>
            {name}
        </div>
    );
};

SearchHistoryItem.propTypes = {
    id: PropTypes.string,
    name: PropTypes.string,
    onChooseCompany: PropTypes.func,
};

export default SearchHistoryItem;
