import React from 'react';
import PropTypes from 'prop-types';

import './Heading.css';

const Heading = ({children, level}) => (
    <div className={`hh-heading hh-heading_level${level}`}>
        {children}
    </div>
);

Heading.defaultProps = {
    level: 3,
};

Heading.propTypes = {
    children: PropTypes.string.isRequired,
    level: PropTypes.number,
};

export default Heading;
