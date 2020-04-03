import React from 'react';

import './Heading.css';


const Heading = ({children, level}) => (
    <div className={`hh-heading__level${level}`}>
        {children}
    </div>
);

export default Heading;
