import React from 'react';

import './Heading.css';


const Heading = ({children, level}) => (
    <div className={`hh-heading hh-heading_level${level}`}>
        {children}
    </div>
);

export default Heading;
