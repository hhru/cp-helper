import React from 'react';
import PropTypes from 'prop-types';

import './SelectWrapper.css';

const SelectWrapper = ({children, lines}) => (
    <div className="select-wrapper" style={lines ? {height: (38 * lines)} : undefined}>
        {children}
    </div>
);

SelectWrapper.defaultProps = {
    lines: 5,
};

SelectWrapper.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
    lines: PropTypes.number,
};

export default SelectWrapper;
