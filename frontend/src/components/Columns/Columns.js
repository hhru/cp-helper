import React from 'react';

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

export default Columns;
