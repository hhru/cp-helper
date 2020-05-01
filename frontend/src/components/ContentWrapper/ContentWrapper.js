import React from 'react';
import PropTypes from 'prop-types';

import './ContentWrapper.css';

const ContentWrapper = ({children}) => (
    <div className="hh-content-wrapper">
        {children}
    </div>
);

ContentWrapper.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
};

export default ContentWrapper;
