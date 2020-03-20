import React from 'react';

import './SelectWrapper.css';


const SelectWrapper = ({children, lines}) => (
    <div className="select-wrapper" style={lines ? {height: (38 * lines)} : undefined}>
        {children}
    </div>
);

SelectWrapper.defaultProps = {
    lines: 5,
};

export default SelectWrapper;
