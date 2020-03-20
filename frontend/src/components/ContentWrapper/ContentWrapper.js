import React from 'react';

import './ContentWrapper.css';


const ContentWrapper = ({children}) => (
    <div className="hh-content-wrapper">
        {children}
    </div>
);

export default ContentWrapper;
