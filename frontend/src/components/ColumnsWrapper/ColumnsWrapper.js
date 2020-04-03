import React from 'react';

import './ColumnsWrapper.css';


const ColumnsWrapper = ({children}) => (
    <div className="columns-row">
        {children}
    </div>
);

export default ColumnsWrapper;
