import React from 'react';
import PropTypes from 'prop-types';

import './ColumnsWrapper.css';

const ColumnsWrapper = ({children}) => (
    <div className="columns-row">
        {children}
    </div>
);

ColumnsWrapper.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
};

export default ColumnsWrapper;
