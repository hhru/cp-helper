import React from 'react';
import PropTypes from 'prop-types';

import './SelectWrapper.css';

const SelectWrapper = ({children, lines, id}) => (
    <div className="select-wrapper"
        style={lines ? {height: (38 * lines)} : undefined}
        id={id}>
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
    id: PropTypes.string,
};

export default SelectWrapper;
