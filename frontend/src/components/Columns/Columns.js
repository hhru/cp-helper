import React from 'react';
import PropTypes from 'prop-types';

import './Columns.css';

const Columns = ({children, s, m, l}) => (
    <div className={`column column_s-${s} column_m-${m} column_l-${l}`}>
        {children}
    </div>
);

Columns.defaultProps = {
    s: 2,
    m: 3,
    l: 6,
};

Columns.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
    s: PropTypes.number,
    m: PropTypes.number,
    l: PropTypes.number,
};

export default Columns;
